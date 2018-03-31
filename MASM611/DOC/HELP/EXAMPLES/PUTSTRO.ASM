
;---------------------------- cut here ----------------------------------
;* PUTSTRO.ASM is a program module containing a procedure to be
;* called by HELLOMO.ASM.

_TEXT   SEGMENT WORD PUBLIC 'CODE'      ; Code segment
        ASSUME  cs:_TEXT

        PUBLIC  C putstr                ; Declare a C public symbol
putstr  PROC    NEAR C                  ; Define a near C procedure
        push    bp                      ; Set up stack frame
        mov     bp, sp

        mov     ah, 02h                 ; Display character function
        mov     di, [bp+4]              ; Load address of string
next:
        mov     dl, [di]                ; Load each character through [DI]
        or      dl, dl                  ; Done if character is zero
        jz      exit
        int     21h                     ; DOS displays character
        inc     di                      ; Point to next character
        jmp     next
exit:
        pop     bp                      ; Destroy stack from and return
        ret

putstr  ENDP

_TEXT   ENDS
        END
