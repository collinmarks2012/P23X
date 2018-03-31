;* HELLOC.ASM illustrates .COM files with full segment directives.
;* Assemble with the "Generate .COM File" linker flag or the
;* /TINY QCL option.
;*
;* Shows:    Directives - SEGMENT   ASSUME    ORG
;*
;* See HELLO.ASM for a simplified segment version or HELLOF.ASM
;* for a full-segment .EXE file version.

_TEXT   SEGMENT WORD PUBLIC 'CODE'
        ASSUME  cs:_TEXT, ds:_TEXT
        ORG     100h

first:
        jmp     start                   ; Jump over data

msg     BYTE    "Hello, world.", 13, 10, "$"

start:
        mov     ah, 9h                  ; Request DOS Function 9
        mov     dx, OFFSET msg          ; Load DX with offset of string
                                        ;   (segment already in DS)
        int     21h                     ; Display String to Standard Output

        mov     ax, 4C00h               ; Exit functions with 0 in AL
        int     21h                     ; Exit Program with Return Code

_TEXT   ENDS

        END     first
