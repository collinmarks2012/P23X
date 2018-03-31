;---------------------------- cut here ----------------------------------
;* PUTSTR.ASM is a program module containing a procedure to be
;* called by HELLOM.ASM. It includes PUTSTR.INC.

IFNDEF  model
model   TEXTEQU  <small>                ; Default small model
ENDIF
        .MODEL  model, c, os_dos
        INCLUDE putstr.inc              ; Prototype for PutStr

        .CODE                           ; Address of string (near or far
putstr  PROC    string:PTR BYTE         ;   depending on model)
        mov     ah, 02h                 ; Display character function

        IF      @DataSize               ; If data is far (compact, large,
        les     di, string              ;   or huge), address is ES:DI
        .WHILE  1
        mov     dl, es:[di]             ; Load each character through ES:[DI]
        ELSE                            ; If data is near (tiny, small,
        mov     di, string              ;   or medium), address is DI only
        .WHILE  1
        mov     dl, [di]                ; Load each character through [DI]
        ENDIF
        .BREAK  .IF dl == 0             ; If character is zero, done
        int     21h                     ; DOS displays character
        inc     di                      ; Point to next character
        .ENDW                           ; Load next character
        ret

putstr  ENDP

        END
