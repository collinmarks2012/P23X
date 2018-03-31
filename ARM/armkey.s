;---------------------------------------------------------------------
; File:     armkey.s
;
; Function: This program copies an ASCII file
;           It assumes the file uses CR/LF as the end of line sequence
;           - It opens an imput file named key.in
;           - It opens an output file named key.out
;           - It reads one line of text from the input file.
;           - It writes that one line to the output file then a CR LF
;           - It loops until it reaches end of file
;           - It closes the input and output file
;
; Author:   Collin Marks
;
; Changes:  Date        Reason
;           ----------------------------------------------------------
;           07/14/2016  Original version
;
;---------------------------------------------------------------------


;----------------------------------
; Software Interrupt values
;----------------------------------
         .equ SWI_Open,  0x66     	;Open  a file
         .equ SWI_Close, 0x68     	;Close a file
         .equ SWI_PrStr, 0x69     	;Write a null-ending string
         .equ SWI_RdStr, 0x6a     	;Read a string and terminate with null char
         .equ SWI_Exit,  0x11     	;Stop execution
;----------------------------------

         .global   _start
         .text

_start:
;----------------------------------
; open input file
; - r0 points to the file name
; - r1 0 for input
; - the open swi is 66h
; - after the open r0 will have the file handle
;----------------------------------
         ldr  r0, =InFileName     	;r0 points to the file name
         ldr  r1, =0              	;r1 = 0 specifies the file is input
         swi  SWI_Open            	;open the file ... r0 will be the file handle
         ldr  r1, =InFileHandle   	;r1 points to handle location
         str  r0, [r1]            	;store the file handle
;----------------------------------


;----------------------------------
; open output file
; - r0 points to the file name
; - r1 1 for output
; - the open swi is 66h
; - after the open r0 will have the file handle
;----------------------------------
         ldr  r0, =OutFileName    	;r0 points to the file name
         ldr  r1, =1              	;r1 = 1 specifies the file is output
         swi  SWI_Open            	;open the file ... r0 will be the file handle
         ldr  r1, =OutFileHandle  	;r1 points to handle location
         str  r0, [r1]            	;store the file handle
;----------------------------------


;----------------------------------
; read a string from the input file
; - r0 contains the file handle
; - r1 points to the input string buffer
; - r2 contains the max number of characters to read
; - the read swi is 6ah
; - the input string will be terminated with 0
;----------------------------------
_process:
         ldr  r0, =InFileHandle   	;r0 points to the input file handle
         ldr  r0, [r0]            	;r0 has the input file handle
         ldr  r1, =InString       	;r1 points to the input string
         ldr  r2, =80           	;r2 has the max size of the input string
         swi  SWI_RdStr           	;read a string from the input file
		 cmp r0, #0x00				; look for EOF seq
		 beq _exit					; if present end program
;----------------------------------

;----------------------------------
; Move the input string to the output string
; This code uses post increment of the input pointer,
; but not for the output pointer ... just to show both techniques
;----------------------------------
         ldr  r0, =InString       	; r0 points to the input  string
         ldr  r1, =OutString      	; r1 points to the output string
_loop:                            	;
		 ldrb r2, [r0], #1        	; get the next input byte
		 cmp r2, #0x00				; we compare to see if null char seq is available
		 beq _finloop				; terminate the program
		 cmp r2, #0X20				; we compare to see if the space char was inputted
		 beq _store					; if it was a space store it to print
		 cmp  r2, #0x7A		 		; compare to z
		 bhi  _loop					; if above z ignore it
		 cmp  r2, #0x60				; compare to lower case a
		 subhi r2, r2, #0X20		; convert to upper
_dontConvert:						;
		 cmp r2, #0x5A				; compare to upper case Z
		 bhi _loop					; if above ignore
		 cmp r2, #0X40				; do 40 bc of only less than
_store:								;
        strhib r2, [r1], #1        	; store it in the output buffer
		b _loop						; continue looping
_finloop: 							;
		strb r2, [r1]				; will effectively load 0
;----------------------------------

;----------------------------------
; Write the outputs string
; Then writes a CR LF pair
;----------------------------------
_print:
         ldr  r0, =OutFileHandle  	; r0 points to the output file handle
         ldr  r0, [r0]            	; r0 has the output file handle
         ldr  r1, =OutString      	; r1 points to the output string
         swi  SWI_PrStr           	; write the null terminated string
         ldr  r1, =CRLF           	; r1 points to the CRLF string
         swi  SWI_PrStr           	; write the null terminated string
		 b _process					; continue processing String
;----------------------------------


;----------------------------------
; Close input and output files
; Terminate the program
;----------------------------------
_exit:                            	;									;
         swi  SWI_Exit            	;terminate the program
;----------------------------------
         .data
;----------------------------------
InFileHandle:  .skip 4            	;4 byte field to hold the input  file handle
OutFileHandle: .skip 4            	;4 byte field to hold the output file handle
									;
InFileName:    .asciz "KEY.IN"   	;Input  file name, null terminated
									;
InString:      .skip 80          	;reserve a 80 byte string for input
OutString:     .skip 80          	;reserve a 80 byte string for output
									;
CRLF:          .byte 13, 10, 0    	;CR LF
									;
OutFileName:   .asciz "KEY.OUT"  	;Output file name, null terminated
;----------------------------------
         .end
