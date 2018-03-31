;* HELLOM.ASM illustrates multiple-modules and memory model
;* independent techniques. It illustrates many new features of
;* MASM 6.1. To build the program, paste HELLOM.ASM, PUTSTR.INC,
;* and PUTSTR.ASM into separate files, compile both, and link.
;*
;* For a similar example that uses older assembly techniques such
;* as full segments, explicit stack frames, and the PUBLIC and EXTERN
;* directives, see HELLOMO.ASM.
;*
;* Shows:   Equates      - @DataSize  @CodeSize
;*          Directives   - PROTO      INVOKE    IFNDEF
;*                         PROC       ENDP
;*          DOS function - 02h (Display Character)

; Model symbol can be passed from command line or environment.
IFNDEF  model
model   TEXTEQU  <small>                ; Default small if no command line
ENDIF
        .MODEL  model, c, os_dos
        .DOSSEG
        INCLUDE putstr.inc
        .STACK                          ; Stack segment
        .DATA                           ; Data segment
msg     BYTE    "Hello, world.", 13, 10, 0      ; Null-terminated string

        .CODE
        .STARTUP                        ; Initialize data and stack segments

        INVOKE  putstr,                 ; Call putstr
                ADDR msg                ;  with msg as argument

        .EXIT                           ; Exit program

        END
