;* HELLOF.ASM - Illustrates full segment directives.
;*
;* Shows:   Directives - SEGMENT     ENDS       GROUP
;*          DOS Functions - 4Ch (Exit Program with Return Code)
;*
;* See HELLO.ASM for a simplified segment version or HELLOC.ASM
;* for a full-segment .COM file version.

        .DOSSEG                         ; Force DOS segment order
DGROUP  GROUP   _DATA, STACK            ; Stack and data in DGROUP

STACK   SEGMENT PARA STACK 'STACK'
        DB      100h DUP (?)            ; 256-byte stack
STACK   ENDS

_DATA   SEGMENT WORD PUBLIC 'DATA'      ; Data segment with string data
msg     DB      "Hello, world.", 13, 10, "$"
_DATA   ENDS

_TEXT   SEGMENT WORD PUBLIC 'CODE'      ; Code segment
        ASSUME  cs:_TEXT, ds:DGROUP, ss:DGROUP

start:
        mov     ax, DGROUP              ; Initialize data segment
        mov     ds, ax

        mov     ah, 9h                  ; Request DOS Function 9
        mov     dx, OFFSET msg          ; Load DX with offset of string
                                        ;   (segment already in DS)
        int     21h                     ; Display String to Standard Output

        mov     ax, 4C00h               ; Exit functions with 0 in AL
        int     21h                     ; Exit Program with Return Code

_TEXT   ENDS

        END     start                   ; End with reference to first
                                        ;   executable statement (CS:IP)
