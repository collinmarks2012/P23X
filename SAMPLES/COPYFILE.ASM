;--------------------------------------------------------------------
;   Program:     COPYFILE *** MASM VERSION ***
;
;   Function:    This program will read characters from the standard input
;                device.  This can be the keyboard or a file that has been
;                redirected to the standard input.
;
;                It allows the software to examine each character.
;
;                The character is then written to the standard output device.
;                This can be the diplay or a file that has been redirected
;                to the standard output.
;
;                The program terminates when the character that has been
;                read and echoed matches the character stored in the
;                variable named 'end_char'.
;
;                If reading from the keyboard then
;                set 'end_char' to be 0Dh (enter key).
;
;                If reading from a file then
;                set 'end_char' to be 1Ah (DOS eof character).
;
;                These are the four possible combinations
;                for reading and writing data:
;                -----------------------------------------------------------
;                copyfile                    input=keyboard   output=display
;                copyfile < input            input=file       output=display
;                copyfile > output           input=keyboard   output=file
;                copyfile < input > output   input=file       output=file
;
;   Restriction: The program hangs if you copy a file without the
;                an EOF character.
;
;   Owner:       Dana Lasher
;
;   Date         Reason
;   ----         ------
;   07/18/2000   New version
;
;---------------------------------------
         .model    small               ; 64k data and 64k code model
         .8086                         ; only allow 8086 instructions
         .stack    256                 ; stack size is 256 bytes
;---------------------------------------

         .data
;---------------------------------------
; The program ends when the last character
; read and echoed matches this variable.
; 1Ah=EOF   0Dh=ENTER
;---------------------------------------
end_char db        0Dh                 ; termination character
;---------------------------------------


         .code
;---------------------------------------
; Establish addressability to the data segment.
;---------------------------------------
start:                                 ;
         mov       ax,@data            ; establish addressability
         mov       ds,ax               ; for the data segment
;---------------------------------------
; Read a charcter without echo.
;---------------------------------------
getloop:                               ;
         mov       ah,8                ; read without echo a character
         int       21h                 ; how: set ah=8 and issue int 21
;---------------------------------------
; The character is now available in the
; al register for processing.
;---------------------------------------

; The program may work on the data in al

;---------------------------------------
; Write out the character and loop if it
; is not the terminating character.
;---------------------------------------
         mov       dl,al               ; move the char to dl
         mov       ah,2                ; write the character from dl
         int       21h                 ; how: set ah=2 and issue int 21
                                       ;
         cmp       dl,[end_char]       ; is this the terminating character
         jne       getloop             ; no, then loop
;---------------------------------------
; When the terminating characater has
; been read and echoed, return to DOS.
;---------------------------------------
exit:                                  ; we processed the terminating character
         mov       ax,4c00h            ; set correct exit code in ax
         int       21h                 ; int 21 will terminate program
         end       start               ; execution begins at the label start
;---------------------------------------
