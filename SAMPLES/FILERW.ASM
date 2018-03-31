;--------------------------------------------------------------------
;
;   Program:   FILERW
;
;   Function:  FILERW will read characters from a file that has been redirected
;              to the standard input.  At the end of each line it will write a
;              message. At the end of file it will write a message.
;
;              It is intended to show how to use file I/O instructions.
;
;              It assumes that all lines end with a CR/LF (0Dh 0Ah).
;              It assumes that all files end with a EOF   (1Ah).
;
;              To run it type: FILERW < in_file > out_file
;              in_file  is the name of your input  file
;              out_file is the name of your output file
;
;   Owner:     Dana Lasher
;
;   Date       Reason
;   ----       ------
;   07/18/2000 New version
;
;---------------------------------------
         .model    small               ; 64k data and 64k code model
         .8086                         ; only allow 8086 instructions
         .stack     256                ; stack size is 256 bytes
;---------------------------------------


         .data
;--------------------------------------------------------
linemsg  db        '... end of line',13,10,13,10,'$'
;
; The end of line message is followed by CR/LF/CR/LF to provide double spacing.
; It is then terminated by a $ which DOS uses to mark the end of a string.
;
;
filemsg  db        '... end of file',13,10,1Ah,'$'
;
; The end of file message is followed by CR/LF/EOF
; which will create a valid final line with an EOF marker.
;--------------------------------------------------------


         .code
;---------------------------------------
; Establish addressability to the data segment.
;---------------------------------------
start:                                 ;
         mov       ax,@data            ; establish addressability
         mov       ds,ax               ; for the data segment
;---------------------------------------
; Read a character without echo and analyze it:
; - if the character is EOF then goto the
;   EOF code without echoing the character
; - for all other characters echo the character
;   to the output stream
; - if the character is EOL then goto EOL code
; - for all other characters loop to read another
;   character from the input stream
;---------------------------------------
progloop:                              ;
         mov       ah,8                ; read a character without echo
         int       21h                 ; how: set ah=8 and issue int 21h
                                       ;
         cmp       al,1Ah              ; is the char eof
         je        eof                 ; yes, go process eof
                                       ;
         mov       dl,al               ; no,  move the char to dl
         mov       ah,2                ; echo the character from dl
         int       21h                 ; how: set ah=2 and issue int 21h
                                       ;
         cmp       dl,0ah              ; is the char eol
         je        eol                 ; yes, go process
                                       ;
         jmp       progloop            ; no,  go process the next character
;---------------------------------------
;   Process the End Of Line condition
;   - output the EOL message
;   - go process the next line
;---------------------------------------
eol:                                   ;
         mov       dx,offset linemsg   ; set dx to point to the message
         mov       ah,9                ; set ah=9
         int       21h                 ; int 21h will write the message
                                       ;
         jmp       progloop            ; go process the next line
;---------------------------------------
;   Process the End Of File condition
;   - output the EOF message including an EOF marker
;   - terminate the program
;---------------------------------------
eof:                                   ;
         mov       dx,offset filemsg   ; set dx to point to the message
         mov       ah,9                ; set ah=9
         int       21h                 ; int 21h will write the message
;---------------------------------------
;   Terminate the program
;---------------------------------------
exit:                                  ;
         mov       ax,4c00h            ; set correct exit code in ax
         int       21h                 ; int 21h will terminate program
         end       start               ;
;---------------------------------------
