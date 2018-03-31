;-----------------------------------------------------------
;
; Program Header
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
		max1 dw 0
		max2 dw 0
		list dw 4 dup(0)



         .code
;---------------------------------------
;
; Code Segment
;
;---------------------------------------
_linkhll:                              ;
		push bp			; saves the callers bp
		mov bp,sp		; loads bp from sp
		add bp, 4		; to move to correct location in bp
		push si			; saves si
		push di			; saves di 
		mov cx, 4		; for loop counter
	
	repeat1:
		mov ax, [bp]	; put current value into ax reg
		cmp max1, ax	; find 1st max
		jg nochange1	; its not a true max
		mov max1, ax	; set a new max
		mov bx, bp		; store address info to find 2nd max
	nochange1:			; dont set a new max
		lea bp, [bp+2]	; continue evaluating remaining items
		loop repeat1	; loop back around
		
		mov cx, 4		; for loop counter
		sub bp, 8		; to return back to start of parameter values
	repeat2:
		cmp bp, bx		; see if the value was the max1
		je nochange2	; if so ignore it
		mov ax, [bp]	; put current value into ax reg
		cmp max2, ax	; see how it compares to current max2
		jg nochange2	; its not one of the top 2 max
		mov max2, ax	; set a new max
	nochange2:
		lea bp, [bp+2]	
		loop repeat2
		
		
	exitMul:	
		mov ax, max1
		mul max2                      
		mov max1, 0
		mov max2, 0
		pop di
		pop si
		pop bp
                                       ;
                                       ;
         ret                           ;
                                       ;
         end                           ;
;---------------------------------------

