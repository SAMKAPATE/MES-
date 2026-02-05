ORG 0000H
; -------- Generate 1513 using arithmetic --------
MOV A, #01H        ; A = 1
MOV B, #0AH        ; B = 10
MUL AB             ; A = 10

ADD A, #05H        ; A = 15
MOV B, #0AH
MUL AB             ; A = 150

ADD A, #01H        ; A = 151
MOV B, #0AH
MUL AB             ; B:A = 05E6H (1510)

ADD A, #04H; B:A = 05E9H (1514)

; -------- Store result in Data Memory --------

MOV 31H, A         ; Store LOW byte (E9H)
MOV 30H, B         ; Store HIGH byte (05H)

HERE: SJMP HERE    ; Stop execution
END
