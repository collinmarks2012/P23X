;* STRUCT.ASM illustrates how to define and use structures, unions,
;* and records.
;*
;* Shows:   Directives     - STRUCT    UNION     ENDS    RECORD
;*          Operators      - WIDTH     MASK
;*          BIOS Interrupt - 10h, Function 09h (Write Character/Attribute)

        .MODEL small, c, os_dos
        INCLUDE macros.inc              ; Include for echof utility macro
        .STACK

; Define, declare, and use structure
        .DATA
DATE    STRUCT
  month BYTE    0                       ; Month, day, and year fields
  day   BYTE    0
  year  WORD    0
  sday  BYTE    "Wednesday"             ; Space for longest day
DATE    ENDS
PDATE   TYPEDEF PTR DATE                ; DATE pointer type
xmas    DATE    <12, 25, 1991, "Friday">; Structure variable
pxmas   PDATE   xmas                    ; Pointer to structure variable
days    DATE    365 DUP (<>)            ; Array of uninitialized structures

        .CODE
        .STARTUP
        inc     xmas.year               ; Increment the year
        mov     al, xmas.day            ; Get day of the month
        mov     bx, pxmas
        mov     cl, [bx].DATE.month     ; Get month through pointer
        mov     si, 358 * SIZEOF DATE   ; Index to 358th day
        mov     days[si].month, cl      ; Initialize array elements
        mov     days[si].day, al

; Define, declare, and use union
        .DATA
BWD     UNION                           ; Union type
  b     BYTE    0
  w     WORD    0
  d     DWORD   0
BWD     ENDS
uvar    BWD     { 0 }

        .CODE
        mov     uvar.w, dx              ; Load DX to word variable field

; Nested structure and union to handle segment and offset of pointer
        .DATA
FP      UNION                           ; Far pointer type
  p     DWORD   0                       ; The whole thing
        STRUCT
  o       WORD  0                       ; Segment part
  s       WORD  0                       ; Offset part
        ENDS
FP      ENDS
fpuvar  FP      { uvar }                ; Far pointer to union array

        .CODE
        les     di, fpuvar.p            ; Load far pointer

        mov     fpuvar.o, bx            ; Store offset
        mov     fpuvar.s, ds            ;   and segment

; Define, declare, and use records
        .DATA
ATTRIB  RECORD  flash:1, bg:3, intense:1, fg:3  ; Type: fbbbifff
FTIME   RECORD  hours:5, minutes:6, second2:5   ; Type: hhhhhmmm mmmsssss
FDATE   RECORD  year:7, month:4, day:5          ; Type: yyyyyyym mmmddddd
now     FTIME   {13, 30, 0}             ; Variable initialized to 1:30 pm
today   FDATE   {11, 1, 1}              ; Variable initialized to 1/1/91

        .CODE
        mov     ax, 0901h               ; Display happy face with attribute
        mov     bl, ATTRIB {0, 3, 1, 7} ; Constant            0 011 1 111
        sub     bh, bh                  ; Page 0
        mov     cx, 10                  ; 10 characters
        int     10h                     ; Display them
                                        ;          NOT MASK   1 000 0 000
        xor     bl, MASK flash          ; Toggle flash bit    1 011 1 111
        int     10h

        mov     dl, bl                  ; Make work copy      1 011 1 111
        and     dl, MASK bg             ; Mask other bits     0 011 0 000
        mov     cl, bg                  ; Get position
        shr     dl, cl                  ; Shift to far right  0 000 0 011
        inc     dl                      ; Increment           0 000 0 100
        shl     dl, cl                  ; Shift back          0 100 0 000
        and     bl, NOT MASK flash      ; Clear original bg   1 000 1 111
        or      bl, dl                  ; Combine             1 100 1 111
        mov     cx, 10
        int     10h

        .EXIT                           ; Terminate Program

        END
