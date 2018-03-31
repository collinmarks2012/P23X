;* HELLO.ASM - Illustrates DOS programming with simplified segment
;* directives.
;*
;* Shows:  Directives    - TITLE     .MODEL    .DOSSEG     .STACK
;*                         .DATA     .CODE     .STARTUP    OFFSET
;*                         .EXIT
;*         Instructions  - int
;*         DOS Functions - 09h (Display String to Standard Output)
;*
;* See HELLOM.ASM for a multi-module version, HELLOMO.ASM for a
;* full-segment version, or HELLOC.ASM for a full-segment .COM

        TITLE   HELLO
        .MODEL  small, c, os_dos        ; Could be any model except flat
        .DOSSEG                         ; Force DOS segment order

        .STACK

        .DATA                           ; Data segment
msg     BYTE    "Hello, world.", 13, 10, "$"

        .CODE                           ; Code segment
        .STARTUP                        ; Initialize data segment and
                                        ;   set SS = DS
        mov     ah, 09h                 ; Request DOS Function 9
        mov     dx, OFFSET msg          ; Load DX with offset of string
                                        ;   (segment already in DS)
        int     21h                     ; Display String to Standard Output

        .EXIT   0                       ; Exit  with return code 0

        END
