; Programmed By: 		Collin Marks

; Purpose : Just Display a String and a Character "A"

.model small			;code and data segment separetly of 64k

.stack 100h			;size in paragraph boundry

.data

		
		; where str is the variable name, db is the keywrod 
		; remember any thing in the string writen is double coutes must write 
		; the dollar sign $ before closing it
		
		chr db 65	; where chr is the variable name and 65 
					; is the ASCII code for A
					
.code
main_:

;your main code or main methods go here

mov ax, @data		;obtain segment address of data

mov ds, ax			; initilize data segment


mov ah, 9			; service no. to display a string

int 21h				; call operating system to do the job

; no dispaly the character A

mov dl, chr			; get AScII code of 'A'

mov ah, 21h			; service no. to display a character

int 21h				; call operating system to do the job

;now terminate the program

mov ah, 4ch			; service no. to terminate the program

int 21h

end main_