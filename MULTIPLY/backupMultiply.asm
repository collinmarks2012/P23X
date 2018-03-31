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
mull:
		shr cx, 1						; divide by two, bottom bit moved to CF
		jnc skip
		add ax, bx						; add element in bx reg to ax reg
		adc dx, di						; reg, reg is faster than reg, imm16
skip:
		add bx, bx						; will multiply bx by 2
		adc di, di
		or cx, cx						; zero check if all zero stop
		jnz mull						; if its zero we have moved throught the entire thing...
exit: 
		pop di
        pop bp               			; restore bp
        ret                           	; return with result in dx:ax
        end                           	; end source code
;---------------------------------------

