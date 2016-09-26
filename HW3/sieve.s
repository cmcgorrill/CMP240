//
//  sieve.s
//  
//
//  Created by Courtney McGorrill on 9/25/16.
//
//
;start is 0x0
AREA |.text|, CODE, READONLY
ENTRY

start

; run sieve 120
LDR r0, =results ; the array
LDR r1, [r0, 8] ; first prime element
ADD r2, N, #1  ; set limit to (N+1)*4[bytes]
MUL r2, r2, #4;
MOV r3, #1 ; 1 marker
MOV r4, #8 ; first prime 'index'
STR r3, [r0,0] ; 0 is not prime
STR r3, [r0,4] ; 1 is not prime
BL sieve_start
STR r0, fact0

loop B loop ; end program

sieve_start

    CMP r4, r2
    BGE exit ; all numbers reached

    MOV r5, #2 ; first multiplier of P

    BL sieve ; start sieve algorithm


    BL find_unmarked


    B sieve_start ; loop

exit
    BX LR

sieve

    MUL r6, r5, r4; find P multiple (2P, 3P, 4P, etc...)
    STR r3, [r1, r6] ; mark the multiple as not prime

    CMP r6, r2 ; if multiple is past limit,
    BGT exit ; return to the caller

    ADD r5, r5, #1 ; P multiplier += 1
    B sieve ; loop

find_unmarked
    ADD r4, r4, #4 ; increment to next int index

    CMP r4, r2 ; if increment is greater than limit
    BGE exit ; return to caller

    CMP [r0,r4], #0 ; check if value at next index is zero
    BEQ exit ; if its zero, return to caller

    B find_unmarked ; loop 

AREA UserData, DATA, READWRITE, ALIGN=3
N  DCD 120
results fill 480, 0

END
