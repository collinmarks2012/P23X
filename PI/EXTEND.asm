;---------------------------------------------------------------------
;   Program:     **MASM** version of extend.asm (which is used to calculate PI)
;
;   Function:    This file contains subroutines that perform
;                extended precision arithmetic.
;                addx - extended precision addition
;                divx - extended precision division
; 				for addx: start the addx subroutine
; 				will initally save all registers on the stack
; 				then it will store the count of the specified list
; 				into the ax register for processing
; 				we move the source index and the
; 				destination index to the end of the list
; 				the LSW and move towards the MSW as per the 
;				specifications of the projlct
;--------------------------------------
;
;   Owner:		Collin Marks
;
;   Last Update: Date            Reason
;                06/27/2016      Finished Product
;---------------------------------------------------------------------
         .model    small            ; 64k code and 64k data
         .8086                      ; only allow 8086 instructions
         public    addx             ; allow linker to access addx
         public    divx             ; allow linker to access divx
;--------------------------------------


;--------------------------------------
;   ADDX Subroutine
;--------------------------------------
         .data						; start the data segment
;--------------------------------------
		ten 	dw 10				; constant for the number 10
		two		dw 2				; constant for the number 2
		quot 	dw ?				; will store the quotient for unrooled loop
		rem 	dw ?				; will store the reminader for unrolled loop
;--------------------------------------
         .code						; start the code segment
;--------------------------------------
; start the addx subroutine
; will initally save all registers on the stack
; then it will store the count of the specified list
; into the ax register for processing
; we move the source index and the
; destination index to the end of the list
; the LSW and move towards the MSW as per the 
; specifications of the projlct
;--------------------------------------
addx:
		push ax						; save registers
		push cx						; save registers
		push si						; save registers
		push di						; save registers
		push dx						; save registers
		mov ax, [si]				; store count in ax reg
		mov dx, 0
		div ten						; we divide for efficiency
		mov quot, ax				; store the quotient for looping
		mov rem, dx					; store the remainder for remaining elements
		mov cx, quot				; move the count to cx reg for loop inst
		mov ax, [si]				; store count in ax reg
		mul two						; convert count of dw's to db's
		add si, ax					; point si to the end of source list
		add di, ax					; point si to the end of dest list
;--------------------------------------
; handles adding the source word and the
; destination word and then storing that
; summed value to the destination 
; list for output as per the projlct specs
; calc will loop for each dw in the list
; as specified in the cx register
; after calc has looped through
; we pop the registers from the stack
; aka we restore the registers
;--------------------------------------
		cmp cx, 0							; see if the quotient is zero if so dont go into calcq
		clc									; clear any carry flags that could have happend with the previous cmp
		jne calcq							; if the quotient is not zero then jump to calcq
		mov cx, rem							; go ahead and set up for calculating the remaining elements
		jmp calcr							; jump past calcq
calcq:
		mov ax, [si]				; store source elem in ax	
		adc [di], ax				; add source and destination elements
		mov ax, [si-2]				; store source elem in ax	
		adc [di-2], ax				; add source and destination elements
		mov ax, [si-4]				; store source elem in ax	
		adc [di-4], ax				; add source and destination elements
		mov ax, [si-6]				; store source elem in ax	
		adc [di-6], ax				; add source and destination elements
		mov ax, [si-8]				; store source elem in ax	
		adc [di-8], ax				; add source and destination elements
		mov ax, [si-10]				; store source elem in ax	
		adc [di-10], ax				; add source and destination elements
		mov ax, [si-12]				; store source elem in ax	
		adc [di-12], ax				; add source and destination elements
		mov ax, [si-14]				; store source elem in ax	
		adc [di-14], ax				; add source and destination elements
		mov ax, [si-16]				; store source elem in ax	
		adc [di-16], ax				; add source and destination elements
		mov ax, [si-18]				; store source elem in ax	
		adc [di-18], ax				; add source and destination elements
		lea si, [si - 20]			; update the source index
		lea di, [di - 20]			; update the destination index
		loop calcq					; loop back until cx returns to 0
mov cx, rem							; this instruction only occurs if calcq was used.  set the rem for the remaining elements
;--------------------------------------
; will do the same as above but handles remaining words
; handles adding the source word and the
; destination word and then storing that
; summed value to the destination 
; list for output as per the projlct specs
; calc will loop for each dw in the list
; as specified in the cx register
; after calc has looped through
; we pop the registers from the stack
; aka we restore the registers
;--------------------------------------
calcr:
		mov ax, [si]				; store source elem in ax					
		adc [di], ax				; add source and destination elements	
		lea si, [si-2]				; update the source index
		lea di, [di -2]				; update the destination index
		loop calcr
		
		
		pop dx						; restore registers
		pop di						; restore registers
		pop si						; restore registers
		pop cx						; restore registers
		pop ax						; restore registers
		ret							; return
stop:
		
		pop dx
		pop di						; restore registers
		pop si						; restore registers
		pop cx						; restore registers
		pop ax						; restore registers
		ret							; return
;--------------------------------------



;--------------------------------------
;   DIVX Subroutine
;--------------------------------------
         .data						; start the data segment
;--------------------------------------
		divisor dw ?				; global divisor
;--------------------------------------
         .code						; start the code segment
;--------------------------------------
; Initially we push all the registers of use
; onto the stack
; We store the count dw from the source list
; into the ax register
; we store this variable into divisor
; which will stay constant across all iterations
;--------------------------------------
divx:
		push ax						; save registers
		push cx						; save registers
		push si						; save registers
		push dx						; save registers
		mov ax, [si]				; store the count variable to ax
		mov divisor, dx				; set the global divisor
		mov dx, 0					; reset dx to avoid divide overflow
		div ten						; divide by 10
		mov quot, ax				; store quotient
		mov rem, dx					; store remainder
		mov cx, quot				; store into cx reg for looping
		mov dx, 0					; set the high word to zero
		lea si, [si+2]				; advance past count 
cmp cx, 0							; see if the quotient is zero if so dont go into calcq
clc									; clear any carry flags that could have happend with the previous cmp
jne calcdq							; if the quotient is not zero then jump to calcq
mov cx, rem							; go ahead and set up for calculating the remaining elements
jmp calcdr							; jump past calcq
;--------------------------------------
; will handle dividing dw's from the source
; list by the specified divisor
; since we are dividing by a word
; the dividend is stored in the dx:ax pair
; with dx initially set to 0000 to guarentee
; that no overflow will occur
; calcd will continue to loop for every word in the source
; list
; after calcd has iterated through every word in the list
; we restore all registers back to their default value
;--------------------------------------
calcdq:
		mov ax, [si]				; place source dw into ax reg
		div divisor					; ax will have quot dx will have rem
		mov [si], ax				; store quot at spot in 
		
		mov ax, [si+2]				; place source dw into ax reg
		div divisor					; ax will have quot dx will have rem
		mov [si+2], ax				; store quot at spot in 
		
		mov ax, [si+4]				; place source dw into ax reg
		div divisor					; ax will have quot dx will have rem
		mov [si+4], ax				; store quot at spot in 
		
		mov ax, [si+6]				; place source dw into ax reg
		div divisor					; ax will have quot dx will have rem
		mov [si+6], ax				; store quot at spot in 
		
		mov ax, [si+8]				; place source dw into ax reg
		div divisor					; ax will have quot dx will have rem
		mov [si+8], ax				; store quot at spot in 
		
		mov ax, [si+10]				; place source dw into ax reg
		div divisor					; ax will have quot dx will have rem
		mov [si+10], ax				; store quot at spot in 
		
		mov ax, [si+12]				; place source dw into ax reg
		div divisor					; ax will have quot dx will have rem
		mov [si+12], ax				; store quot at spot in 
		
		mov ax, [si+14]				; place source dw into ax reg
		div divisor					; ax will have quot dx will have rem
		mov [si+14], ax				; store quot at spot in 
		
		mov ax, [si+16]				; place source dw into ax reg
		div divisor					; ax will have quot dx will have rem
		mov [si+16], ax				; store quot at spot in 
		
		mov ax, [si+18]				; place source dw into ax reg
		div divisor					; ax will have quot dx will have rem
		mov [si+18], ax				; store quot at spot in 
		
		lea si, [si +20]			; advance si pointer to next element
		loop calcdq					; loop back around
		
		mov cx, rem					; set remainder in cx var for next loop
		cmp cx, 0					; if remainder was zero exit
		je exit						; exit
;--------------------------------------
; will do the same as above but will handle remaining words
; will handle dividing dw's from the source
; list by the specified divisor
; since we are dividing by a word
; the dividend is stored in the dx:ax pair
; with dx initially set to 0000 to guarentee
; that no overflow will occur
; calcd will continue to loop for every word in the source
; list
; after calcd has iterated through every word in the list
; we restore all registers back to their default value
;--------------------------------------
calcdr:
		mov ax, [si]				; place source dw into ax reg
		div divisor					; division
		mov [si], ax				; store the quotient into source list
		lea si, [si+2]				; advance pointer
		loop calcdr					; loop back around
;--------------------------------------
; will effectively 
; end the divx subroutine
; will also restore registers
;--------------------------------------
		
exit:
		pop dx						; restore registers
		pop si						; restore registers
		pop cx						; restore registers
		pop ax						; restore registers
		ret                         ; return
;--------------------------------------
end									; effectively end extend.asm
