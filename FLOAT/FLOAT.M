;---------------------------------------------------------------------
; This program calculates pi.
;
; It uses the the Salamin-Brent algorithm.
; It uses only the primitive floating point operations.
; - It does its own calculation of square roots.
; - It converts the floating point value to characters for printing.
;
; Algorithm
;
;    Salamin-Brent algorithm
;
;    a   = 1.0;                          // a0 = 1
;    b   = 1.0 / sqrt (2.0);             // b0  = 1 / sqrt(2)
;    s   = 1.0;                          // s is the sum in the denominator
;    t   = 1.0;                          // the first value of 2**k when k = 0
;    old = 0.0;                          // last value of pi calculated
;
;    while (1)                           // loop forever
;       {
;       s = s - t * (a - b) * (a - b);   // subtract next value of sum from s
;       pi = 4 * a * a / s;              // calc new value of pi
;       c = (a + b) / 2.0;               // calc an+1 = (an + bn)/2
;       d = sqrt (a * b);                // calc bn+1 = sqrt(an * bn)
;       a = c;                           // set an+1
;       b = d;                           // set bn+1
;       t = 2 * t;                       // calc next value of 2**k
;       output(pi);                      // print the current value of pi
;       if (pi == old) break;            // exit the loop if pi is not changing
;       old = pi;                        // save the current value of pi
;       }
;
;
; Owner:
;
; Updated     Reason
; ----------------------------
; 06/29/2011  Original version
;
;
;---------------------------------------------------------------------


;---------------------------------------
         .model    small               ;4 segments of 64KB
         .8086                         ;only  8086 instructions
         .stack    256                 ;stack size is 256 bytes
         extern    output:proc         ;output subroutine is in another file
         extern    sqroot:proc         ;sqroot subroutine is in another file
;---------------------------------------

;---------------------------------------
; Data for the main program
;
; Note ... MASM does not allow a variable named c
;          so we use the name cc.
;
;---------------------------------------
         .data                         ;
a        dd        1.0                 ;a0 = 1
b        dd        0.707106781         ;b0 = 1 / sqrt(2)
cc       dd        0.0                 ;work value  (cc is the variable c)
d        dd        0.0                 ;work value
s        dd        1.0                 ;s is the sum in the denominator
t        dd        1.0                 ;the first value of 2**k when k = 0
old      dd        0.0                 ;last value of pi calculated
two      dd        2.0                 ;constant 2.0
four     dd        4.0                 ;constant 4.0
pi       dd        0.0                 ;current value of pi
lstat    dw        0                   ;NDP control word
status   dw        0                   ;NDP status register
temp     dd        0.0                 ;a temporary work variable
;---------------------------------------
; The code should converge to a correct
; answer in 5 loops. In case there is a
; bug in the program we limit the number
; of loops to 20.
;---------------------------------------
maxloop  dw        20                  ;
;---------------------------------------


;---------------------------------------
         .code                         ;
start:                                 ;
;---------------------------------------
; Intialize the DS register.
; Initialize the NDP floating-point CPU.
;---------------------------------------
         mov       ax,@data            ;establish addressability
         mov       ds,ax               ;to the data segment
                                       ;
         finit                         ;initialize the NDP
         fnstcw    [lstat]             ;get the NDP's control word
         and       [lstat], 0FCFFh     ;set single precision
         fldcw     [lstat]             ;store the updated NDP control word
;---------------------------------------


;--------------------------------------------------
; Calculate each line of the algorithm
;--------------------------------------------------


;---------------------------------------
; s = s - t * (a - b) * (a - b);   // subtract next value of sum from s
;---------------------------------------
piloop:                                ;


         ;***********************************
         ; You code this statement
         ; s = s - t * (a - b) * (a - b);
         ;***********************************


;---------------------------------------
;    pi = 4 * a * a / s;     // calc new value of pi
;---------------------------------------


         ;***********************************
         ; You code this statement
         ; pi = 4 * a * a / s;
         ;***********************************


;---------------------------------------
;    c = (a + b) / 2.0;      // calc an+1 = (an + bn)/2
;---------------------------------------


         ;***********************************
         ; You code this statement
         ; c = (a + b) / 2.0;
         ;
         ; Note that MASM does not allow the
         ; variable name c so we use the
         ; variable named cc
         ;
         ; cc = (a + b) / 2.0;
         ;
         ;***********************************


;---------------------------------------
;    d = sqrt (a * b);       // calc bn+1 = sqrt(an * bn)
;---------------------------------------
         fld       [a]                 ;push a
         fld       [b]                 ;push b
         fmul                          ;calc a*b
         call      sqroot              ;calc sqrt(a*b)
         fstp      [d]                 ;pop  d
;---------------------------------------
;    a = c;        // set an+1
;---------------------------------------
         fld       [cc]                ;push c
         fstp      [a]                 ;pop  a
;---------------------------------------
;    b = d;        // set bn+1
;---------------------------------------
         fld       [d]                 ;push d
         fstp      [b]                 ;pop  b
;---------------------------------------
;    t = 2 * t;    // calc next value of 2**k
;---------------------------------------
         fld       [t]                 ;push t
         fld       [t]                 ;push t
         fadd                          ;calc 2*t
         fstp      [t]                 ;pop t
;---------------------------------------
;    output(pi);   // print the current value of pi
;---------------------------------------
         fld       [pi]                ;push pi
         call      output              ;output pi
         fstp      [pi]                ;pop  pi
;---------------------------------------
;    if (pi == old) break;    // exit the loop if pi is not changing
;---------------------------------------
         fld       [pi]                ;push pi
         fld       [old]               ;push old
         fcompp                        ;calculate pi - old
         fstsw     [status]            ;store the floating point status
         fwait                         ;wait until store is complete
         mov       ax,[status]         ;ax = floating point status
         sahf                          ;store ah into main cpu status
         je        piend               ;exit if pi == old
;---------------------------------------
;    if we loop 20 times we also terminate
;---------------------------------------
         dec       [maxloop]
         je        piend
;---------------------------------------
;    old = pi;     // save the current value of pi
;---------------------------------------
         fld       [pi]                ;push pi
         fstp      [old]               ;pop  old
         jmp       piloop              ;loop
;---------------------------------------
; Terminate the program
;---------------------------------------
piend:                                 ;
         mov       ax,4c00h            ;set DOS termination code
         int       21h                 ;terminate
;---------------------------------------

         end       start

