;* HELLOS2.ASM - Illustrates OS/2 programming with MASM 6.0.
;*
;* Shows:  Directives - INCLUDE   INCLUDELIB
;*
;* See HELLO.ASM for a DOS version.

        .MODEL  small, c, os_os2
        .286

INCL_NOCOMMON   EQU    1                ; No common definitions
INCL_VIO        EQU    1                ; For VioWrtTTy
INCL_DOSPROCESS EQU    1                ; For DosExit (used by .EXIT)
        INCLUDE OS2.INC                 ; OS/2 include files
        INCLUDELIB OS2.LIB              ; OS/2 systems call library

        .STACK                          ; Stack segment

        .DATA                           ; Data segment

msg     BYTE    "Hello, world.", 13, 10

        .CODE                           ; Code segment
        .STARTUP                        ; Initialize data segment

        INVOKE  VioWrtTTy,              ; Function name
                ADDR msg,               ; Address of string
                LENGTHOF msg,           ; Length of string
                0                       ; Handle of standard video

        .EXIT   0                       ; Exit with return code 0

        END
