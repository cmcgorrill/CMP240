	;start is 0x0
	AREA |.text|, CODE, READONLY
	ENTRY

start
	
	; run factorial 0
	MOV r0, #0
	BL factorial_start
	STR r0, fact0
	
	; run factorial 1
	MOV r0, #1
	BL factorial_start
	STR r0, fact1
 
	; run factorial 2
	MOV r0, #2
	BL factorial_start
	STR r0, fact2
	
	; run factorial 5
	MOV r0, #5
	BL factorial_start
	STR r0, fact5
	LDR r1, fact5
	
	; run factorial 12
	MOV r0, #12
	BL factorial_start
	STR r0, fact12
	
	; run int division 9/2
	MOV r0, #9
	MOV r1, #2
	MOV r2, #0
	BL int_division
	STR r0, div9
	
	; run int division 10/2
	MOV r0, #10
	MOV r1, #2
	MOV r2, #0
	BL int_division
	STR r0, div10
	
	; run int division 11/2
	MOV r0, #11
	MOV r1, #2
	MOV r2, #0
	BL int_division
	STR r0, div11
	
	; run power 21 0
	MOV r0, #21
	MOV r1, #0
	BL power_start
	STR r0, pow0
	
	; run power 21 1
	MOV r0, #21
	MOV r1, #1
	BL power_start
	STR r0, pow1
	
	; run power 21 2
	MOV r0, #21
	MOV r1, #2
	BL power_start
	STR r0, pow2
	
	; run power 21 7
	MOV r0, #21
	MOV r1, #7
	BL power_start
	STR r0, pow7
	
	
loop B loop ; end program

factorial_start
	; set sum, current multiplication, make copy of input
	; if argument == 0
	;	return 1
	; start factorial calculation

	MOV r1, #0 ; current count
	MOV r2, r0 ; copy of input
	MOV r0, #1 ; start sum
	
	CMP r2, #0
	BEQ exit ; input is 0, return instantly
	
	B factorial ; start calculating factorial
	
exit
	BX LR

factorial
	; add 1 to current number to multiply
	; multiply sum * current number to multiply
	; if current == number passed in
	; 	return
	; recurse back to factorial

	ADD r1, r1, #1
	MUL r0, r1, r0 ; multiply together
	CMP r1, r2 ; have you reached your starting point?
	BNE factorial
	
	BX LR ; return to the caller

int_division
	; subtract denominator from numerator
	; if num < 0
	; 	return value in r2
	; add 1 to count of # of divides
	; recurse back to int_division

	SUB r0, r0, r1 

	CMP r0, #0 ; if < 0, then dont add one to the # of divides and end
	BLT end_common
	
	ADD r2, r2, #1 ; increment the # of divides
	B int_division
	
end_common
	MOV r0, r2
	BX LR
	
power_start
	; if exponent == 0
	;	return 1
	; set loop counter
	; set sum
	
	; start calculating power
	
	CMP r1, #0
	BEQ power_zero
	
	MOV r3, r1 ; exponent counter
	MOV r2, r0 ; start sum
	
	
power
	; if exponent counter == 1
	; 	return sum
	; multiply current sum and base passed in
	; decrement counter
	; recurse back to power
	
	CMP r3, #1 ; no more powers
	BEQ end_common ; return
	
	MUL r2, r0, r2
	SUB r3, r3, #1 ; reduce counter
	B power ; loop

power_zero
	MOV r0, #1
	BX LR

	AREA UserData, DATA, READWRITE, ALIGN=3
fact0  DCD -1
fact1  DCD -1
fact2  DCD -1
fact5  DCD -1	
fact12 DCD -1	
div9   DCD -1
div10  DCD -1
div11  DCD -1
pow0   DCD -1	
pow1   DCD -1	
pow2   DCD -1	
pow7   DCD -1	
	END
