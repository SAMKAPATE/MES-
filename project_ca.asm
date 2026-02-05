ORG 0000H

; Initialization
MOV R0, #40H    ; R0 = Scanner pointer for both passes
MOV R1, #40H    ; R1 = Writer pointer (used in second pass)
MOV R2, #00H    ; R2 = Counter for valid (non-FFH) bytes

; First Pass: Count valid bytes
COUNT_LOOP:
    CJNE R0, #60H, READ_COUNT  ; If R0 reaches 60H, end count
    SJMP COMPACT              ; Jump to compact phase
READ_COUNT:
    MOV A, @R0                ; Read byte
    CJNE A, #0FFH, INC_COUNT  ; If not FFH, increment counter
    SJMP NEXT_COUNT           ; Skip if FFH
INC_COUNT:
    INC R2                    ; Increment valid count
NEXT_COUNT:
    INC R0                    ; Advance scanner
    SJMP COUNT_LOOP           ; Loop

; Second Pass: Compact valid data
COMPACT:
    MOV R0, #40H              ; Reset R0 to start
    MOV R1, #40H              ; Reset R1 to start
COMPACT_LOOP:
    CJNE R2, #00H, READ_COMPACT ; If count > 0, continue compacting
    SJMP FILL_ZERO            ; If count == 0, jump to fill
READ_COMPACT:
    MOV A, @R0                ; Read byte
    CJNE A, #0FFH, WRITE_COMPACT ; If valid, write it
    SJMP NEXT_COMPACT         ; Skip if FFH
WRITE_COMPACT:
    MOV @R1, A                ; Write to writer position
    INC R1                    ; Advance writer
    DEC R2                    ; Decrement count (one valid byte processed)
NEXT_COMPACT:
    INC R0                    ; Advance scanner
    SJMP COMPACT_LOOP         ; Loop

; Fill Phase: Fill remaining with 00H
FILL_ZERO:
    CJNE R1, #60H, WRITE_ZERO ; If R1 < 60H, fill
    RET                       ; Done
WRITE_ZERO:
    MOV @R1, #00H             ; Write 00H
    INC R1                    ; Advance
    SJMP FILL_ZERO            ; Loop