;--------------------------------------------------------------------
;	program: 	LINKHLL
;
;	function: 	The LinkHLL subroutine will find the maximum
; 				of 4 parameter values
; 				and then constructs the product of the 2 maxs.
;				We will search for the 2 maxs and then return
;				the product
;
;	owner: 		Collin Marks
;
;	date: 		06/30/2016
;---------------------------------------
;
; The LinkHLL subroutine will find the maximum
; of 4 parameter values
; and then construct the product of the 2 maxs
;
;---------------------------------------
         .model    small               ;
         .8086                         ;
         public    _linkhll            ;
;---------------------------------------

         .data
;---------------------------------------
;
; Data Segment
;
;---------------------------------------

         .code
;---------------------------------------
;
; Code Segment
;
; initially pushes all the pointers for
; subroutine
;
;---------------------------------------
_linkhll:
		push bp			; saves the callers bp
		mov bp,sp		; loads bp from sp
		mov ax, [bp+4]	; store values into the reg
		mov bx, [bp+6]	; put value into 
		mov cx, [bp+8]	; put value into cx
		mov dx, [bp+10]	; put value into dx
		cmp ax, cx		; cmp ax to cx
		ja A			; if ax < cx then swap them
		xchg ax, cx		; swaps ax and cx
;---------------------------------------
; will process relation between ax and dx
;---------------------------------------		
	A:
		cmp ax, dx		; cmp ax to dx
		ja B			; if ax < dx then swap them 
		xchg ax, dx		; swap ax and dx
;---------------------------------------
; will process relation between bx and cx
;---------------------------------------	
	B:
		cmp bx, cx		; cmp bx to cx
		ja D			; if bx < cx then swap them
		xchg bx, cx		; swaps bx and cx
;---------------------------------------
; will process relation between bx and dx
;---------------------------------------	
	D:
		cmp bx, dx		; cmp bx to dx
		ja E			; if bx < dx swap them
		xchg bx, dx		; swaps bx and dx
;---------------------------------------
; will effectively construct the multiplicand
; and will end program
;---------------------------------------	
	E:	
		mul bx			; multiply ax and bx register
		pop bp			; restore registers
        ret             ; return values will be in dx:ax pair
        end             ; effectively terminate the subroutine
;---------------------------------------

