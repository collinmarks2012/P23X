;--------------------------------------------------------------------
;	program: 	KEY
;
;	function: 	KEY reads printable characters from the Standard Input
;				The characters are processed one at a time as they are read
;				If the character is an upper case letter (A-Z) then write 
;				it to the standard output (ah=02h, dl=char, int 21h).
;				If the character is a lower case letter (a-z) then convert
;				it to upper case and write it to the standard output.
;				You can perform this conversion by subtracting 20h 
;				from the lower case letter.
;				If the character is a blank (20h) or period (2Eh) then 
;				write it to the standard output.
;				If the character is anything else then do not write it 
; 				to the standard output, just throw the character away.
;
;	owner: 		Collin Marks
;
;	date: 		06/04/2016
;---------------------------------------
    .model     small 				; 64k code and 64k data
	.8086 							; only allow 8086 instructions
	.stack 256 						; reserve 256 bytes for the stack
;---------------------------------------
	.data 							; start the data segment
;---------------------------------------
; Declaration of the variable trans
;---------------------------------------
	tran db 32 dup('*')					; the 32 characters below space
		 db ' '							; the space character
		 db 32 dup('*')					; the 32 character b/w space and 'A'
		 db 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'	; A-Z in upper case
		 db 6 dup('*')					; the 6 characters b/w 'Z' and 'a'
		 db 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'	; A-Z in upper case
		 db 133 dup('*')				; the remaining characters
;---------------------------------------
	.code 							;start the code segment
;---------------------------------------
; start the program
;---------------------------------------
start:
	mov ax,@data 					;establish addressability to the
	mov ds,ax 						;data segment for this program
;---------------------------------------
; While loop will continue to run until a period is inputted
;---------------------------------------
	whileP:
		mov bx, offset tran 	; bx will point to the 'morphed' ASCii table
		mov ah, 8 				; code to read from DOS
		int 21h					; read a char
								; if a period is present end the program
		cmp al, 46				; check to see if period is inputted
		je endProgram			; if period is present end the program
		xlat				; translate the char to 'morphed' table
		cmp al, 42				; check to see if a special character 
								; was inputted
		je whileP				; ignore that special character
		mov ah, 2				; code to write the char
		mov dl, al				; move the char to dl
		int 21h					; write the character
		jmp whileP				; continue through the loop
	
;---------------------------------------
; Will effectively end the program
;---------------------------------------
	endProgram:
		mov ah, 2			; code to write last char
		mov dl, '.'			; write a period to dl register
		int 21h				; write the period char
		mov ax, 4c00h		; close program process 
		int 21h
		end start