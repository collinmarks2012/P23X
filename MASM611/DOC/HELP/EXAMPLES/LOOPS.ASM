;* LOOPS.ASM - Illustrates directives that control looping. The
;* following directives can be used in place of loops generated
;* with the LOOP, LOOPNE, LOOPE, JCXC, and conditional jump
;* instructions. See LOOPSO.ASM for an example of old-style loops.
;*
;* Shows:  Directives   - .REPEAT   .UNTIL    .UNTILCXZ
;*                        .WHILE    .ENDW
;*                        .BREAK    .CONTINUE
;*         DOS function - 07h (Raw Input, No Echo)

        .MODEL  small, c, os_dos        ; Small model (could be any model)
        .DOSSEG                         ; Force DOS segment order
        .STACK
        .DATA
msg1    BYTE    13, 10, "Iteration: "   ; Iteration message
num1    BYTE    0, "$"                  ; Place holder for iteration byte
msg2    BYTE    13, 10, "Alphabet: $"   ; Alphabet message
num2    BYTE    0, " $"                 ; Place holder
msg3    BYTE    13, 10, "Type digits, then press ENTER: $"

        .CODE
        .STARTUP                        ; Initialize

; A simple loop that repeats until CX is zero. This is equivalent to a
; LOOP instruction.

        mov     cx, 9
        sub     bl, bl
        .REPEAT
        mov     bl, 10                  ; Calculate iteration number
        sub     bl, cl
        mov     num1, bl                ; Copy number to memory
        add     num1, '0'               ; Convert to ASCII

        mov     ah, 09h                 ; Request DOS Function 9
        mov     dx, OFFSET msg1         ; Load offset of string
        int     21h                     ; Display string
        .UNTILCXZ

; This conditional loop does its test at the end. It will always execute
; at least once, regardless of entry conditions.

        mov     dx, OFFSET msg2         ; Load offset of string
        int     21h                     ; Display string
        mov     bl, 'a'
        .REPEAT                         ; While lowercase letter:
        mov     num2, bl                ; Copy letter to memory
        inc     bl                      ; Next letter
        mov     dl, bl                  ; Load for display

        mov     ah, 09h                 ; Request DOS Function 9
        mov     dx, OFFSET num2         ; Load offset of string
        int     21h                     ; Display string
        .UNTIL  bl > 'z'

        mov     ah, 09h                 ; Request DOS Function 9
        mov     dx, OFFSET msg3         ; Load offset of string
        int     21h                     ; Display string

; A common loop in assembler is one with the conditional test in the
; middle. This loop has two tests--one that breaks and one that
; continues to the top of the loop.

        .WHILE  1                       ; Loop forever (or until break)
        mov     ah, 07h                 ; Get key without echo
        int     21h

        .BREAK  .IF al == 13            ; Terminate if ENTER
        .CONTINUE .IF (al < '0') || (al > '9')  ; Skip if not digit

        mov     dl, al                  ; Copy
        mov     ah, 02h                 ; Output character
        int     21h
        .ENDW

        .EXIT   0                       ; Exit  with return code 0

        END
