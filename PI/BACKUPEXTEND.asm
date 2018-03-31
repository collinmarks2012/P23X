;---------------------------------------------------------------------
;   Program:     **MASM** version of extend.asm (which is used to calculate PI)
;
;   Function:    This file contains subroutines that perform
;                extended precision arithmetic.
;                addx - extended precision addition
;                divx - extended precision division
;
;   Owner:		Collin Marks
;
;   Last Update: Date            Reason
;                06/03/2012      Original version
;
;---------------------------------------------------------------------
         .model    small               ;64k code and 64k data
         .8086                         ;only allow 8086 instructions
         public    addx                ;allow linker to access addx
         public    divx                ;allow linker to access divx
;--------------------------------------


;--------------------------------------
;   ADDX Subroutine
;--------------------------------------
         .data
		two		dw 2
		s		dw ?				; source word to add	
		d		dw ?				; destination word to add
		zero	dw 0
         .code
;--------------------------------------
addx:
		push ax						; save registers
		push cx						; save registers
		push si						; save registers
		push di						; save registers
		mov ax, [si]				; # of words in list
		mov cx, ax
		mul two
		add si, ax					; move si to LSW in list
		add di, ax					; move di to LSW in list
	
calc:								; note that at this point ax is either 0 or 1
		mov ax, [si]				; store source elem in ax			
		adc [di], ax				; add source and destination
		sub si, 2					; move to MSW in source list
		sub di, 2					; move to MSW in source list
		loop calc
		
		pop di
		pop si
		pop cx
		pop ax
		ret
		
		
		
		;--------------------------------------



;--------------------------------------
;   DIVX Subroutine
;--------------------------------------
         .data



         .code
;--------------------------------------
divx:                                 ;
                                      ;
         ret                          ; return
;--------------------------------------

         end
