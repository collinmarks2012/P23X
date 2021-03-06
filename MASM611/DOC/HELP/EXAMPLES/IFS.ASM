;* IFS.ASM - Illustrates directives that control looping. The following
;* directives can be used in place of conditional statements generated
;* with CMP, TEST, and conditional jumps:
;*
;* Shows:  Directives - .IF       .ELSE     .ENDIF      .ELSEIF
;*

        .MODEL  small, c, os_dos        ; Small model (could be any model)
        .DOSSEG                         ; Force DOS segment order
        .STACK
        .DATA                           ; Data segment
msg     BYTE    "Time: "                ; Time message
ampm    BYTE    "AM", 13, 10

        BYTE    "Season: $"             ; Season messages
winter  BYTE    "Winter$"
spring  BYTE    "Spring$"
summer  BYTE    "Summer$"
autumn  BYTE    "Autumn$"

        .CODE                           ; Code segment
        .STARTUP                        ; Initialize

        mov     ah, 2Ch                 ; Get time
        int     21h

; Simple IF based on the common construct of assuming one value, then
; adjusting if the assumption is wrong.

        .IF     ch >= 12                ; If noon or later:
        mov     ampm, 'P'               ; Adjust message from AM to PM
        .ENDIF

        mov     dx, OFFSET msg          ; Load address of message
        mov     ah, 09h                 ; Display $-terminated string
        int     21h

        mov     ah, 2Ah                 ; Get date
        int     21h

; Complex IF testing numerous conditions and ranges. This code looks is
; simpler than the comparable conditional jumps because multiple conditions
; are evaluated in each expression.

        .IF     (dh == 12) || (dh < 3)  ; If December, January, or February:
        mov     dx, OFFSET winter
        .ELSEIF (dh >= 3) && (dh < 6)   ; If March, April, or May:
        mov     dx, OFFSET spring
        .ELSEIF (dh >= 6) && (dh < 9)   ; If June, July, or August:
        mov     dx, OFFSET summer
        .ELSE                           ; Must be September, October,
        mov     dx, OFFSET autumn       ;  or November
        .ENDIF
        mov     ah, 09h                 ; Display message
        int     21h

        .EXIT   0                       ; Exit  with return code 0

        END
