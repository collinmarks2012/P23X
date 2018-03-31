;* HELLOS22.ASM - Illustrates flat model programming for OS/2 2.0
;* with MASM 6.0.
;*
;* Shows:  flat
;*
;* See HELLO.ASM for a DOS version or HELLOS2.ASM for OS/2 1.x version.

        .386
        .MODEL  flat, pascal, os_os2

; No prototypes provided, so we must give our own:
DosWrite PROTO NEAR32 SYSCALL,
        hf:DWORD, pvBuf:PTR, cbBuf:DWORD, pcbBytesWritten:PTR DWORD

DosExit PROTO NEAR32 SYSCALL,
        fTerminate:DWORD, ulExitCode:DWORD

        INCLUDELIB OS2_386.LIB          ; OS/2 systems call library

        .STACK                          ; Stack segment

        .DATA                           ; Data segment

msg     BYTE    "Hello, world.", 13, 10
written DWORD   0

        .CODE                           ; Code segment

start:
        INVOKE  DosWrite,               ; Function name
                1,                      ; File handle for screen
                ADDR msg,               ; Address of string
                LENGTHOF msg,           ; Length of string
                ADDR written            ; Bytes written

        INVOKE  DosExit,                ; Exit with return code 0
                0,
                0

        END     start
