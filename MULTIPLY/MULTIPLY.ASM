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
; will push registers
; load multiplicand
; load multiplier
; check for multiplication by zero if so exit
; else begin constructing mul operand
;---------------------------------------
_multiply:
        push bp                  		; save bp
        mov  bp, sp               		; anchor bp into the stack
		push di							; save di register
        mov  cx, [bp+4]           		; load multiplicand from the stack
        mov  bx, [bp+6]           		; load multiplier   from the stack
		xor ax, ax 						; check for mul by zero cheap way to zero out reg
		mov dx, ax						; clear out ax and dx
		mov di, cx						; di contains multiplicand
		or di, bx						; test for zero on both regs
										; if all zero then will 
		jz exit							; exit/returing dx:ax which 
										; is both zero at this point
		mov di, ax						; we will use di for reg, reg adc
;---------------------------------------
; Handles multiplication of 1st bit
; and handles carries from previous bit
; then it will handle the next add with carry for next bit
;---------------------------------------	
A:		
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc B							; if no carry go ahead an add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16
;---------------------------------------
; Handles multiplication of 2nd bit
; and handles carries from previous bit
;---------------------------------------	
B:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc C1							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16
;---------------------------------------
; Handles multiplication of 3rd bit
; and handles carries from previous bit
;---------------------------------------	
C1:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc D							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16
;---------------------------------------
; Handles multiplication of 4th bit
; and handles carries from previous bit
;---------------------------------------	
D:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc E							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16
;---------------------------------------
; Handles multiplication of 5th bit
; and handles carries from previous bit
;---------------------------------------	
E:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc F							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16	
;---------------------------------------
; Handles multiplication of 6th bit
; and handles carries from previous bit
;---------------------------------------	
F:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc G							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16
;---------------------------------------
; Handles multiplication of 7th bit
; and handles carries from previous bit
;---------------------------------------	
G:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc H							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16
;---------------------------------------
; Handles multiplication of 8th bit
; and handles carries from previous bit
;---------------------------------------	
H:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc I							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16	
;---------------------------------------
; Handles multiplication of 9th bit
; and handles carries from previous bit
;---------------------------------------			
I:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc J							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16
;---------------------------------------
; Handles multiplication of 10th bit
; and handles carries from previous bit
;---------------------------------------	
J:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc K							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16
;---------------------------------------
; Handles multiplication of 11th bit
; and handles carries from previous bit
;---------------------------------------	
K:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc L							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16	
;---------------------------------------
; Handles multiplication of 12th bit
; and handles carries from previous bit
;---------------------------------------	
L:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc M							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16	
;---------------------------------------
; Handles multiplication of 13th bit
; and handles carries from previous bit
;---------------------------------------	
M:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc N							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16	
;---------------------------------------
; Handles multiplication of 14th bit
; and handles carries from previous bit
;---------------------------------------	
N:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc O							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16	
;---------------------------------------
; Handles multiplication of 15th bit
; and handles carries from previous bit
;---------------------------------------	
O:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc P							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16	
;---------------------------------------
; Handles multiplication of 16th and last bit
; and handles carries from previous bit
;---------------------------------------
P:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc Q							; if no carry go ahead and add else handle the CF
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16
;---------------------------------------
; Handles multiplication of 1st bit
; and handles carries from previous bit
; then it will handle the next add with carry for next bit
;---------------------------------------			
Q:
		add bx, bx						; will multiply bx by 2
		adc di, di						; carry into di portion of word
;---------------------------------------
; will effectively
; end the program
; ending the multiply subroutine
;---------------------------------------	
exit: 
		pop di
        pop bp               			; restore bp
        ret                           	; return with result in dx:ax
        end                           	; end source code
;---------------------------------------

