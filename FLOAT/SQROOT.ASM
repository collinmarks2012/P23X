;---------------------------------------
; SQROOT
;
; Calculates the square root of n using Newton's iteration:
;
;    gp = (g*g + n)/2*g
;
; where g is the old guess and gp the new value calculated.
;
; The code iterates until we cannot improvethe new value.
; This is recognized when gp=g.
;
; Input:  The value of n    is passed in  the ST register
; Output: The value of root is passed out the ST register
;
; Owner:  Dana lasher
;
; Updated:    Reason
; ------------------
; 06/21/2011  Original version
;
;
;---------------------------------------
                                       ;
         .model    small               ;small memory model
         .8086                         ;only 8086 instructions
         public    sqroot              ;allow linker to find this subroutine
                                       ;
;---------------------------------------
; Data segment for the square root rtn.
;---------------------------------------
         .data                         ;
g        dd        0.0                 ;initial guess
gp       dd        0.0                 ;new calculated value
half     dd        0.5                 ;constant of 0.5
val      dd        0.0                 ;calc the square root of this number
status   dw        0                   ;NDP status register
;---------------------------------------

;---------------------------------------
; Start by retrieving the value of n.
;---------------------------------------
         .code                         ;
sqroot:                                ;
         fstp      [val]               ;save n
;---------------------------------------
; Use n/2 as the first guess.
;
; Although not a particularly good estimate, it is easy to calculate.
;---------------------------------------
         fld       [val]               ;push n onto the stack
         fld       [half]              ;push 1/2
         fmul                          ;calc n/2
         fstp      [g]                 ;the initial guess g = n/2
;---------------------------------------
; Calculate gp = (g*g + n)/2*g
;---------------------------------------
froot_1:                               ;
         fld       [val]               ;push n onto the stack
         fld       [g]                 ;push g
         fdiv                          ;calculate n/g
         fld       [g]                 ;push g
         fadd                          ;calculate (g + n/g)
         fld       [half]              ;push 1/2
         fmul                          ;0.5 * (g + n/g)
         fstp      [gp]                ;store new guess
;---------------------------------------
; Determine if gp == g
;
; This follows the procedure specified in the assignment which requires
; copying the NDP status register to the x86 status register.
;---------------------------------------
         fld       [gp]                ;push gp
         fld       [g]                 ;push g
         fcompp                        ;calculate gp - g
         fstsw     [status]            ;store the floating point status
         fwait                         ;wait until store is complete
         mov       ax,[status]         ;ax = floating point status
         sahf                          ;store ah into main cpu status
         je        froot_2             ;exit if g == gp
         fld       [gp]                ;else move gp
         fstp      [g]                 ;     to   g
         jmp       froot_1             ;     and loop
;---------------------------------------
; When gp == g we can return the value of gp as the root of n.
;---------------------------------------
froot_2:                               ;
         fld       [gp]                ;push gp onto the stack
         ret                           ;return
;---------------------------------------

         end
