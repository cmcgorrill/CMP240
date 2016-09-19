	AREA |.text|, CODE, READONLY	; required
	ENTRY				; required
	ldr r1, x			; VALUE of X
	ldr r2, y			; VALUE of y
	add r2, r1, r2		; R2 = x+y
	str r2, r		    
	lsl r1,r1,#2		
	add r1, r1, #12		
	str r1, z			; put r1 into z
	ldr r3, =q	
	sub r3,r3,#12
	bx r3
	str r3, x
	str r3, y
	str r3, z
hang
	b hang
	
	;Data at 0x40
	AREA UserData, DATA, READWRITE, ALIGN=3	; required
q	DCD -1			; Note RPI uses  x: .int 15
r 	DCD 0
x 	DCD 252
y 	DCD 8
z 	DCD 666
	END			; required

    END