; Q2: Demonstration of comparison for all three cases
; Result codes:
; 01H -> First value greater
; 00H -> Both values equal
; FFH -> First value smaller
ORG 0000H
; -------- Test Case 1 : A > B --------
MOV R2, #05H        ; First number
MOV R3, #03H        ; Second number
ACALL CMP_LOGIC
MOV 52H, A          ; Store result of Case 1
; -------- Test Case 2 : A = B --------
MOV R2, #05H
MOV R3, #05H
ACALL CMP_LOGIC
MOV 53H, A          ; Store result of Case 2
; -------- Test Case 3 : A < B --------
MOV R2, #02H
MOV R3, #07H
ACALL CMP_LOGIC
MOV 54H, A          ; Store result of Case 3
STOP:
SJMP STOP
;-------- Comparison Subroutine --------
CMP_LOGIC:
LOOP_CMP:
    MOV A, R2
    JZ FIRST_ZERO

    MOV A, R3
    JZ SECOND_ZERO

    DEC R2
    DEC R3
    SJMP LOOP_CMP

FIRST_ZERO:
    MOV A, R3
    JZ SAME
    MOV A, #0FFH     ; A < B
    RET
SECOND_ZERO:
    MOV A, R2
    JZ SAME
    MOV A, #01H      ; A > B
    RET

