<<<<<<< HEAD
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
=======
	AREA |.text|, CODE, READONLY	; required
	ENTRY				; required
	mov r1, #1
	mov r2, #2
	ldr r3, =x			; ADDRESS of X
	ldr r4, y		    	; The VALUE of y 
	ldr r5, [r3]			; The VALUE of X 
	add r6, r5, #-1		; r5 = r4-1
	str r7, y			; put r1 into x
	ldr r8, y			; just checking
Loop B Loop		;infinite loop
	AREA UserData, DATA, READWRITE, ALIGN=3	; required
x	DCD 15			; Note RPI uses  x: .int 15
y 	DCD 0xbad0
	END			; required

    END
>>>>>>> 74f0b46354aff425ffe163b2db165de9bfc558d3
