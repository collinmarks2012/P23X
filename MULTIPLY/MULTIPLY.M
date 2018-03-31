;-----------------------------------------------------------
;
; Program:  MULTIPLY
;
; Function: Multiplies two 16 bit unsigned values ...
;           .... duplicating the MUL instruction
;
; Input:    The two values to be multiplied are passed on the stack
;           The code conforms to the C/C++ calling sequence
;
; Output:   The 32 bit result is returned in the dx:ax pair
;           Registers required by C/C++ need to be saved and restored
;
; Owner:
;
; Changes:  Date        Reason
;           ------------------
;           07/20/2013  Original version
;
;
;---------------------------------------
         .model    small
         .8086
         public    _multiply

         .data
;---------------------------------------
; Multiply data
;---------------------------------------


         .code
;---------------------------------------
; Multiply code
;---------------------------------------
_multiply:                             ;
         push      bp                  ; save bp
         mov       bp,sp               ; anchor bp into the stack
         mov       ax,[bp+4]           ; load multiplicand from the stack
         mov       dx,[bp+6]           ; load multiplier   from the stack

;  calculate multiplicand * multiplier
;  return result in dx:ax

         pop       bp                  ; restore bp
         ret                           ; return with result in dx:ax
                                       ;
         end                           ; end source code
;---------------------------------------

