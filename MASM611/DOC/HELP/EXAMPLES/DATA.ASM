;* DATA.ASM illustrates how to declare variables with data-definition
;* directives.
;*
;* Shows:   Directives - BYTE     WORD     DWORD    QWORD    TWORD
;*                       TYPEDEF  LABEL
;*          Operator -   DUP      LENGTH   []       "        '

        .MODEL small, c, os_dos
        .8087
        .STACK

; Storing and loading numeric variables
        .DATA
bvar    BYTE    16                      ; Byte initialized as 16
wvar    WORD    4 * 3                   ; Word initialized as 12
dvar    DWORD   4294967295              ; Double word as 4,294,967,295
qvar    QWORD   ?                       ; Quad word (8-byte) uninitialized
        BYTE    1, 2, 3, 4, 5           ; Five initialized bytes
ten     TBYTE   2345                    ; 10-byte integer as 2,345

fp      REAL8   6.3153                  ; 8-byte real number

        .CODE
        .STARTUP
        mov     bl, bvar                ; Load byte variable to AL
        mov     ax, WORD PTR dvar[0]    ; Load doubleword to DX:AX
        mov     dx, WORD PTR dvar[2]
                                        ; Uncomment for coprocessor
;       fld     fp                      ; Load real variable into ST(0)

; Storing, loading, and using strings and characters

FPBYTE  TYPEDEF FAR  PTR BYTE           ; Far pointer to byte type
NPBYTE  TYPEDEF NEAR PTR BYTE           ; Near pointer to byte type

        .DATA
abc     BYTE    'a', 'b', 'c'           ; Three characters (same as "abc")
hello   BYTE    'Hello', 13, 10, '$'    ; String for DOS Function 09h
msg     BYTE    13, 10,                 ; String for DOS Function 40h
                "Another hello"         ;   (extends across two lines)
dir     BYTE    "C:\C\CPROGS", 0        ; String data for C
npdir   NPBYTE  dir                     ; Near pointer to char (C string)
fpdir   FPBYTE  dir                     ; Far pointer to char (C string)

        .CODE
        mov     dx, OFFSET hello        ; Load and write $-terminated string
        mov     ah, 09h                 ; Display String
        int     21h
        mov     dx, OFFSET msg          ; Load and write string with length
        mov     cx, LENGTHOF msg        ; Length of msg
        mov     bx, 1                   ; File handle of the screen
        mov     ah, 40h                 ; Write File or Device
        int     21h                     ;
        lds     dx, fpdir               ; Load far pointer to ASCIIZ to DS:DX
        mov     ah, 3Bh                 ; Set Current Directory
        int     21h

; Storing and using arrays, buffers, structures, and unions

        .DATA
PDWORD  TYPEDEF PTR DWORD               ; Pointer to doubleword type
dbuf    DWORD   25 DUP (?)              ; 25 uninitialized doublewords
bbuf    BYTE    12 DUP ("month")        ; 60-byte array, each 5-byte
                                        ;   group initialized to "month"
pdbuf   PDWORD  dbuf                    ; C array is pointer to array data
twodim  WORD    5 DUP (5 DUP (0))       ; Allocate 25 words initialized to 0

darr1   LABEL   DWORD                   ; Access array as 25 doublewords
warr1   LABEL   WORD                    ; Access same array as 50 words
barr1   BYTE    100 DUP (1, 2, 4, 8)    ; Access array as 100 bytes, each
                                        ;   group initialized to bit mask
        .CODE
        mov     bx, OFFSET bbuf         ; Load offset of buffer
        .REPEAT                         ; Repeat for each
        mov     BYTE PTR [bx], 'M'      ; Put data in array
        add     bx, 5                   ; Move to next array element
        .UNTIL  bx >= (OFFSET bbuf + (12 * 5))

        .EXIT                           ; Terminate Program

        END
