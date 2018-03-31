;--------------------------------------------------------------------
;	program: 	TABS
;
;	function: 	TABS reads lines fron a ASCII text file whic is 
;				redirected to the standard input, converts a tab 
;				character to the correct number of space to obtain 
;				"column" formmatting.  
;				If the character of interest is a tab we need to 
;				input the correct number of spaces so that each word 
;				is "columnar" formatting.  
;				If the character is not a tab just input that specific 
;				character 
;
;	owner: 		Collin Marks
;
;	date: 		06/10/2016
;---------------------------------------
    .model     small 				; 64k code and 64k data
	.8086 							; only allow 8086 instructions
	.stack 		256					; reserve 256 bytes for the stack
;---------------------------------------

;---------------------------------------
	.data 							; start the data segment
;---------------------------------------
	lineCount 	dw 	0				; lineCount will count the number of
;---------------------------------------

;---------------------------------------
	.code 							;start the code segment
;---------------------------------------

;---------------------------------------
; start the program
;---------------------------------------
start:
	mov ax,@data 				; establish addressability to the
	mov ds,ax 					; data segment
	
;---------------------------------------
; handle commmand line parameter
;---------------------------------------
	mov cl, 10					; initalize the spacing to default 10
	cmp byte ptr es:[80h], 0	; Compare the clp to 0 aka no clp
	je 	whileP					; jump to default setting of 10
	mov cl, byte ptr es:[82h]	; if there was a clp move to cl reg
	sub cl, 48					; subtract 48 due to ASCII hex conv
;---------------------------------------

;---------------------------------------
; loop for each char in the text file
; it will initially read in a character
; if the character is a tab
; input enough spaces for proper column spacing
; else we will go ahead and print the char to standard output
; if the char printed was the LF character then we handle conditions
; for termintating the line and reseting the line counter
;---------------------------------------
	whileP:
		mov ah, 8 				; code to read from DOS
		int 21h					; read a char
		cmp al, 09h				; check to see if tab is present
		je inputSpace			; if a tab is present insert correct tabs
		inc lineCount			; increase the line counter
		mov ah, 2				; code to write the char
		mov dl, al				; move the char to dl
		int 21h					; write the character
		cmp dl, 1Ah				; check to see if char is END OF FILE CHAR
								; aka SUB char
		je endProgram			; if period is present end the program
		cmp dl, 0Ah				; Look for Line Feed if so reset lineCount
		jne whileP				; termination of a line has been reached
		mov lineCount, 0		; original spacing
		jmp whileP				; then continue processing chars
;---------------------------------------
	
;---------------------------------------
; input the correct number of spaces
; we take in the lineCount to determine the correct
; number of spaces to go to standard output
; for each space inputted we continue to increase the 
; lineCounter.  If lineCount mod spacing is 0 then we stop
; in other words if the linecount is divisible by the spacing
; with a remainder of 0 we stop and return to the while loop
;---------------------------------------
	inputSpace:					; will input enough space	
		mov ah, 2				; to maintain "column" spacing
		mov dl, ' '				; input space to dl reg
		int 21h					; interupt
		inc lineCount			; increase the line counter
		mov ax, lineCount		; set the current lineCount for division
		div cl					; divide ax reg by the lineCount
		cmp ah, 0				; if remainder = 0 stop, else continue
		je whileP				; if rem =0 jump back to next char
		jmp inputSpace			; else continue with spaces
;---------------------------------------

;---------------------------------------
; effectively end the program
;---------------------------------------
	endProgram:					; Will effectively end the program
		mov ax, 4c00h			; normal step to end program
		int 21h					; interupt
		end start				; end the program...
;---------------------------------------