;---------------------------------------------------------------------
;   Program:     **MASM** version of extend.asm (which is used to calculate PI)
;
;   Function:    This file contains subroutines that perform
;                extended precision arithmetic.
;                addx - extended precision addition
;                divx - extended precision division
;
;   Owner:
;
;   Last Update: Date            Reason
;                06/03/2012      Original version
;
;---------------------------------------------------------------------
         .model    small               ;64k code and 64k data
         .8086                         ;only allow 8086 instructions
         public    addx                ;allow linker to access addx
         public    divx                ;allow linker to access divx
;--------------------------------------


;--------------------------------------
;   ADDX Subroutine
;--------------------------------------
         .data



         .code
;--------------------------------------
addx:                                 ;
                                      ;
         ret                          ;return
;--------------------------------------



;--------------------------------------
;   DIVX Subroutine
;--------------------------------------
         .data



         .code
;--------------------------------------
divx:                                 ;
                                      ;
         ret                          ; return
;--------------------------------------

         end
