;---------------------------------------------------------------------
; File:     hello.s
;
; Function: This program writes 'hello world' to the file hello.out
;
; Author:   Dana Lasher
;
; Changes:  Date        Reason
;           ----------------------------------------------------------
;           05/09/2013  Original version
;---------------------------------------------------------------------

;----------------------------------
; Software Interrupt values
;----------------------------------
         .equ SWI_Open,  0x66     ;Open  a file
         .equ SWI_Close, 0x68     ;Close a file
         .equ SWI_PrStr, 0x69     ;Write a null-ending string
         .equ SWI_RdStr, 0x6a     ;Read a string and terminate with null char
         .equ SWI_Exit,  0x11     ;Stop execution
;----------------------------------
                                  ;
         .global   _start         ;start will be known to external programs
         .text                    ;start instructions
                                  ;
;----------------------------------
; open output file
; - r0 points to the file name
; - r1 1 for output
; - the open swi is 66h
; - after the open r0 will have the file handle
;----------------------------------
_start:                           ;
         ldr  r0, =OutFileName    ;r0 points to the file name
         ldr  r1, =1              ;r1 = 1 specifies the file is output
         swi  SWI_Open            ;open the file ... r0 will be the file handle
         ldr  r1, =OutFileHandle  ;r1 points to handle location
         str  r0, [r1]            ;store the file handle
;----------------------------------

;----------------------------------
; Write the outputs string
;----------------------------------
         ldr  r0, =OutFileHandle  ;r0 points to the output file handle
         ldr  r0, [r0]            ;r0 has the output file handle
         ldr  r1, =OutString      ;r1 points to the output string
         swi  SWI_PrStr           ;write the null terminated string
;----------------------------------

;----------------------------------
; Close output file
; Terminate the program
;----------------------------------
_exit:                            ;
         ldr  r0, =OutFileHandle  ;r0 points to the output file handle
         ldr  r0, [r0]            ;r0 has the output file handle
         swi  SWI_Close           ;close the file
                                  ;
         swi  SWI_Exit            ;terminate the program
;----------------------------------

;----------------------------------
         .data                    ; start data
;----------------------------------
OutFileHandle: .skip 4            ;4 byte field to hold the output file handle
                                  ;
OutString:   .asciz "hello world" ;the output string
                                  ;
OutFileName: .asciz "HELLO.OUT"   ;Output file name, null terminated
;----------------------------------

         .end
