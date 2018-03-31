;--------------------------------------------------------------------
;   Program:  Hello (MASM version)
;
;   Function: Writes "Hello World" to the standard output device.
;             It is equivalent to the famous C++ program, hello world.
;
;             It uses 3 constant declarations to generate the message,
;             to show that dos writes data until it finds a '$'.
;
;             A single constant will also work, such as
;             msg  db  'Hello World',13,10,'$'
;
;             In assembler you have as much flexibility as you want.
;
;   Owner:    DAL
;
;   Date:     Changes
;   01/26/01  original version
;
;---------------------------------------
         .model     small              ;64k code and 64k data
         .8086                         ;only allow 8086 instructions
         .stack     256                ;reserve 256 bytes for the stack
;---------------------------------------


;---------------------------------------
         .data                         ;start the data segment
;---------------------------------------
msg      db        'Hello World'       ;the hello world message
eol      db        13,10               ;cr/lf = \n in c++
term     db        '$'                 ;dos end of string
                                       ;
msglen   dw        term-msg+1          ;total length of the message
;---------------------------------------


;---------------------------------------
         .code                         ;start the code segment
;---------------------------------------
hello:                                 ;
         mov       ax,@data            ;establish addressability to the
         mov       ds,ax               ;data segment for this program
;---------------------------------------
; write out the message
;---------------------------------------
         mov       dx,offset msg       ;point to the message
         mov       ah,9                ;set the dos code to write a string
         int       21h                 ;write the string
;---------------------------------------
; terminate program execution
;---------------------------------------
exit:                                  ;
         mov       ax,4c00h            ;set dos code to terminate program
         int       21h                 ;return to dos
         end       hello               ;end marks the end of the source code
                                       ;....and specifies where you want the
                                       ;....program to start execution
;---------------------------------------
