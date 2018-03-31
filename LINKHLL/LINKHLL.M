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
		list dw 4dup(0)



         .code
;---------------------------------------
;
; Code Segment
;
;---------------------------------------
_linkhll:                              ;
		push bp			; saves the callers bp
		mov bp,sp		; loads bp from sp
		push si			; saves si
		push di			; saves di 
		
		mov si, offset list
		mov [si], [bp+4]	; add elems to list
		mov [si+2], [bp+6]	; add elems to list
		mov [si+4], [bp+8]	; add elems to list
		mov [si+6], [bp+10]	; add elems to list
		mov cx, 4			; for loop counter
	
	repeat:
		cmp max1, [si]
		jg nochange
		
		mov max1, [si]
	nochange:
		add si, 2
		loop repeat
		
		cmp max1, ax
		jg nochange
		mov
		
		
                                       ;
                                       ;
                                       ;
         ret                           ;
                                       ;
         end                           ;
;---------------------------------------

