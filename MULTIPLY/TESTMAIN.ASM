;--------------------------------------------------------------------
;
; Program:    testmain
;
; Function:   This is a simple driver for the multiply subroutine
;             that allows you to specify the two numbers to be
;             multiplied and then more easily run the debugger
;
; Operation:  1. Set the input numbers num1 and num2
;             2. Assemble and link testmain.asm and multiply.asm
;                ml   /c /Zi /Fl testmain.asm
;                ml   /c /Zi /Fl multiply.asm
;                link /CO testmain.obj multiply.obj
;             3. Run the debugger
;                cv testmain
;
; Author:     Dana Lasher
;
; Changes:    Date           Reason
;             -------------------------------------------------------
;             07/20/2013     Original version
;
;
;---------------------------------------
         .model    small               ; 4 64KB segments
         .8086                         ; only 8086 instructions
         .stack    256                 ; 256 byte stack
         extrn     _multiply:proc      ; multiply is in another file
;---------------------------------------


;---------------------------------------
         .data                         ; start the data segment
num1     dw        10                  ; multiplicand for ax
num2     dw        100                 ; multiplier   for dx
                                       ;
;---------------------------------------


;---------------------------------------
; Initialize the ds register
;---------------------------------------
         .code                         ; start the code segment
start:                                 ; the program starts execution here
         mov       ax,@data            ; establish addressability
         mov       ds,ax               ; to the data segment
;---------------------------------------
;
; **********************************
; * When using the debugger these  *
; * are the instructions you want  *
; * to trace                       *
; **********************************
;
;---------------------------------------
;
; The C calling code is ...
;     multiply (multiplicand, multiplier);
;
;---------------------------------------
callmul:                               ;
         push      [num2]              ; push multiplier
         push      [num1]              ; push multiplicand
         call      _multiply           ; call the multiply subroutine
                                       ;
retpoint:                              ; verify dx:ax has the right product
         add       sp,4                ; pop parameters off the stack
;---------------------------------------
; See if dx:ax has the correct product
;---------------------------------------


;---------------------------------------
; Terminate the program
;---------------------------------------
         mov       ax,4c00h            ; DOS terminate code
         int       21h                 ; terminate
         end       start               ; the first instruction is start:
;---------------------------------------


