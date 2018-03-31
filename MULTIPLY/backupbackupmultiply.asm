;-----------------------------------------------------------
;
; Program:  MULTIPLY
;
; Function: Multiplies two 16 bit unsigned values ...
;           .... duplicating the MUL instruction
;
; Input:    The two values to be multiplied are passed on the stack
;           The code conforms to the C/C++ calling sequence
;
; Output:   The 32 bit result is returned in the dx:ax pair
;           Registers required by C/C++ need to be saved and restored
;
; Owner:	Collin Marks
;
; Changes:  Date        Reason
;           ------------------
;           07/01/2016  Original version
;
;
;---------------------------------------
         .model    small
         .8086
         public    _multiply

         .data
;---------------------------------------
; Multiply data
;---------------------------------------


         .code
;---------------------------------------
; Multiply code
;---------------------------------------
_multiply:                            	; 
        push bp                  	; save bp
        mov  bp, sp               		; anchor bp into the stack
        mov  cx, [bp+4]           		; load multiplicand from the stack
        mov  bx, [bp+6]           		; load multiplier   from the stack
		push di

		xor ax, ax 						; check for mul by zero cheap way to zero out reg
		mov dx, ax						; clear out ax and dx
		mov di, cx						; di contains multiplicand
		or di, bx						; test for zero on both regs
										; if all zero then will 
		jz exit							; exit/returing dx:ax which 
										; is both zero at this point
		mov di, ax						; we will use di for reg, reg adc

A:		
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc B							; if no carry go ahead an add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16
B:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc C1							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16
C1:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc D							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16
D:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc E							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16
E:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc F							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16	
F:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc G							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16
G:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc H							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16
H:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc I							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16		
I:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc J							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16
J:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc K							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16
K:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc L							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16	
L:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc M							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16	
M:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc N							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16	
N:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc O							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16	
O:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc P							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16	
P:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc Q							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16	
Q:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
exit: 
		pop di
        pop bp               			; restore bp
        ret                           	; return with result in dx:ax
        end                           	; end source code
;---------------------------------------

