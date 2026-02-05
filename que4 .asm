ORG 0000H

; -------- Construct high byte of 6199 (184FH decimal ? 18H high, 4FH low) --------

; High byte = 18H
MOV R0, #08H      ; lower nibble
MOV R1, #10H      ; upper nibble

MOV A, R0
ANL A, #0FH       ; mask lower nibble
ORL A, R1         ; combine nibbles ? A = 18H
MOV B, A          ; store high byte in B (16-bit number B:A)

; Low byte = 4FH
MOV R2, #0FH      ; lower nibble
MOV R3, #40H      ; upper nibble

MOV A, R2
ANL A, #0FH       ; mask lower nibble
ORL A, R3         ; combine nibbles ? A = 4FH

; -------- Result --------
; B:A = 184FH ? 6199 decimal

HERE: SJMP HERE    ; infinite loop to stop
END
