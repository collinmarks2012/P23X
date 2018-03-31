;--------------------------------------------------------------------
;
;   TESTKEYS ***** MASM VERSION *****
;
;
;   TESTKEYS.  This program will read ASCII characters from the
;   keyboard (standard input stream).  Each ASCII character read will
;   be converted to its hex equivalent, and then written to the
;   standard output device.  For example the character 'A' will be
;   output as '41' and Enter will be output as '0D'.  This allows the
;   user to view all the characters that can be typed, including
;   the control characters.  Some other examples of the conversion are:
;
;       Character       Internal            Converted   Output
;       in file         representation      to          as
;       ------------------------------------------------------
;       A               41h                 34 31       41
;       =               3Dh                 33 44       3D
;       z               7Ah                 37 41       7A
;
;   The program terminates when a period is read.
;
;   To use, type this command:  TESTKEYS
;
;   Owner: Dana Lasher
;
;   Date       Reason
;   ----       ------
;   06/10/00   Original version
;
;---------------------------------------
         .model small                  ; 64k data and 64k code
         .8086                         ; only allow 8086 instructions
         .stack 256                    ; stack size is 256 bytes
;---------------------------------------

         .data
;---------------------------------------
codes    db        '0123456789ABCDEF'  ; codes of ASCII encoded hex digits
;---------------------------------------

         .code
;---------------------------------------
; Establish addressability to the data segment.
; Initialize the work register.
; - bx is cleared to zero and will be used as
;   an index register in the conversion process
;---------------------------------------
start:                                 ;
         mov       ax,@data            ; establish addressability
         mov       ds,ax               ; for the data segment
         mov       bx,0                ; clear index register
;---------------------------------------
; Try to read from the keyboard.
; - program only terminates when a period
;   is read from the keyboard)
;---------------------------------------
getloop:                               ;
         mov       ah,8                ; read without echo a character
         int       21h                 ; how: set ah=8 and issue int 21h
         mov       cl,al               ; no,  save the character (cl=xy)
;---------------------------------------
; Convert each character represented by a
; hex byte into two printable ASCII characters.
; Example: character = 'A' = 41h.
; Output as ASCII '4' and ASCII '1'.
;
; Get the printable version of the most
; significant hex digit and print it.
; Example: character = 'A' = 41h
; Output and ASCII '4'
;---------------------------------------
         mov       bl,cl               ; move the hex byte to bx (bx=00xy)
         shr       bx,1                ; isolate
         shr       bx,1                ;  the left
         shr       bx,1                ;   hex digit
         shr       bx,1                ;    bx=000x
         mov       dl,[codes+bx]       ; use bx as index into ASCII codes
         mov       ah,2                ; write the ASCII code
         int       21h                 ; how: set ah=2 and issue int 21h
;---------------------------------------
; Get the printable version of the least
; significant hex digit and print it.
; Example: character = 'A' = 41h
; Output and ASCII '1'
;---------------------------------------
         mov       bl,cl               ; move the hex byte to bx (bx=00xy)
         and       bx,000fh            ; isolate right hex digit (bx=000y)
         mov       dl,[codes+bx]       ; use bx as index into ASCII codes
         mov       ah,2                ; write the ASCII code
         int       21h                 ; how: set ah=2 and issue int 21h
;---------------------------------------
; Print a blank to separate characters.
;
; If the character was a period then terminate,
; else loop to read another character.
;---------------------------------------
         mov       dl,' '              ; write out a blank
         mov       ah,2                ; set up to write the character
         int       21h                 ; how: set ah=2 and issue int 21h
         cmp       cl,'.'              ; was the character a period
         jne       getloop             ; no, loop
;---------------------------------------

;---------------------------------------
; The user typed a period so terminate.
;---------------------------------------
exit:                                  ;
         mov       ax,4c00h            ; set correct exit code in ax
         int       21h                 ; int 21h will terminate program
         end       start               ; execution begins at the label start
;---------------------------------------
