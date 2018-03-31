;---------------------------------------
; OUTPUT
;
; Converts a floating point number to ASCII characters and outputs the characters.
;
; It does this by
; - isolating the cuurent integer ... get 4 from 4.789
; - outputting the 4
; - removing the 4 from the value ... 4.789 --> 0.789
; - multiplying the value by 10 to get the next integer ... 0.789 --> 7.89
;
; Input:  The value to be converted passed in the ST register.
; Output: The characters are written to the standard output device.
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
         public    output              ;allow linker to find this subroutine
                                       ;
;---------------------------------------
; Data for output routine                                               Example
;---------------------------------------                                  |
         .data                         ;                                  |
outval   dd        0.0                 ;convert this to characters       4.789
intval   dd        0.0                 ;current integer part of outval   4.000
bintval  dw        0                   ;binary value of current integer  0004h
ten      dd        10.0                ;constant 10
crlf     db        13,10,'$'           ;new line characters
lstat    dw        0                   ;control word for NDP
switch   dw        0                   ;first digit=0 else=1
status   dw        0                   ;NDP status register
;---------------------------------------

;---------------------------------------
; Save the input value which is to be converted.
;
; Set the loop count to 6 so we output 6 digits.
;---------------------------------------
         .code                         ;
output:                                ;output subroutine
         fstp      [outval]            ;save the value
         fld       [outval]            ;push the value back onto the stack
         mov       cx,6                ;loop count is 6
         mov       [switch],0          ;set for printing the first digit
;---------------------------------------
; Normally when we round, we want to use the default of rounding to the
; neartest value so 4.789 would round to 5.
;
; However, when extracting the current integer we want to just truncate
; the fraction so ; 4.789 becomes 4 and not 5.
;
; To do this we tell the NDP to truncate when extracting the current integer.
;
; This code extracts the current integer and converts it a 16 bit binary number
; 0004 so it can then be converted to an ASCII '4' = 34h so it can be printed.
;---------------------------------------
printval:                              ;
         fnstcw    [lstat]             ;get the NDP's control word
         or        [lstat], 0c00h      ;set control bits in NDP to truncate
         fldcw     [lstat]             ;store the updated NDP control word
                                       ;
         fld       [outval]            ;push the current value       4.789
         frndint                       ;truncate it to integer       4.000
         fstp      [intval]            ;save the integer value
                                       ;
         fld       [intval]            ;push integer value on stack  4.000
         fistp     [bintval]           ;convert to 16 bit binary     0004h
                                       ;
         fnstcw    [lstat]             ;get the NDP's control word
         and       [lstat], 0f3ffh     ;set NDP to round to nearest value
         fldcw     [lstat]             ;store the updated NDP control word
;---------------------------------------
; Convert the binary value of the integer 0004 to ASCII 34h and print it.
; If this is the first digit then print the decimal point.
;---------------------------------------
         mov       dx,[bintval]        ;dl contains the binary 8 bit value
         add       dl,'0'              ;convert to ASCII
         mov       ah,2                ;set DOS code to write a character
         int       21h                 ;write the character
                                       ;
         cmp       [switch],0          ;was this the first digit
         jne       pr_01               ;no, skip
         mov       dl,'.'              ;yes, get the decimal point
         mov       ah,2                ;set DOS code to write a character
         int       21h                 ;write the character
         mov       [switch],1          ;indicate we did the decimal point
pr_01:                                 ;
;---------------------------------------
; After printing the current interger, determine the next integer value to print.
;
; This is done by removing the current integer 4.789 --> .789
; then multiplying by 10 so that .789 --> 7.89
;---------------------------------------
         fld       [outval]            ;push value on stack          4.789
         fld       [intval]            ;push integer part            4
         fsub                          ;subtract integer part        0.789
         fld       [ten]               ;push 10
         fmul                          ;mul by 10 to get next digit  7.890
         fstp      [outval]            ;save the value
;---------------------------------------
; Loop for 6 digits.
;---------------------------------------
         loop      printval            ;loop
;---------------------------------------
; Output a newline and return.
;---------------------------------------
         mov       dx, offset crlf     ;point to newline string
         mov       ah,9                ;set DOS code to write a string
         int       21h                 ;write the newline string
                                       ;
         ret                           ;return
;---------------------------------------

         end
