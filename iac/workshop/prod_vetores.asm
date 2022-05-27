PLACE 1000H

VEC1: WORD 10
VEC2: WORD 7

PLACE 0H

MOV R3, VEC1
MOV R4, VEC2
MOV R5, 6


produto_vetorial_loop:
    MOV R1, [R3]
    MOV R2, [R4]

    ADD R3, 2
    ADD R4, 2

    MUL R1, R2

    ADD R0, R1

    DEC R5
    JZ end
    JMP produto_vetorial_loop

end:
    JMP end


