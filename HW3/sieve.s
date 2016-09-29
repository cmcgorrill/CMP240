	;start is 0x0
	AREA |.text|, CODE, READONLY
	ENTRY
start
	; run sieve 120
	LDR r0, =results ; the array
	LDR r1, [r0, #8] ; first prime element
	MOV r3, #4
	MOV r4, #121 ; set limit to (N+1)*4[bytes]
	MUL r2, r3, r4 ;
	MOV r3, #-1 ; -1 marker
	MOV r7, #1 ; 1 marker
	MOV r4, #8 ; first prime 'index'
	STR r3, [r0,#0] ; 0 is not prime
	STR r3, [r0,#4] ; 1 is not prime
	BL sieve_start
	STR r0, results
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
	CMP r6, r2 ; if multiple is past limit,
	BGT exit ; return to the caller
	STR r3, [r0, r6] ; mark the multiple as not prime
	ADD r5, r5, #1 ; P multiplier += 1
	B sieve ; loop

find_unmarked
	ADD r4, r4, #4 ; increment to next int index
	CMP r4, r2 ; if increment is greater than limit
	BGE exit ; return to caller
	LDR r8, [r0, r4]
	CMP r8, r3 ; check if value at next index is zero (r3>value) 
	BGT set_prime	; if its zero, set prime, return to caller
	B find_unmarked ; loop 
	
set_prime
	STR r7, [r0, r4] 
	B exit
	
	AREA UserData, DATA, READWRITE, ALIGN=3
results fill 480, 0

END
