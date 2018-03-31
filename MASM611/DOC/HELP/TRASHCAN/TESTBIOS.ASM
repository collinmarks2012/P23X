        .MODEL  small, pascal, DOS
        INCLUDE BIOS.INC

PVOID   TYPEDEF      PTR
FPVOID  TYPEDEF FAR  PTR
NPVOID  TYPEDEF NEAR PTR

        .STACK
        .DATA

        .CODE
        .STARTUP

comment ^

        @GetMode
        @SetMode MACRO mode

        @SetColor MACRO color
        @SetPalette MACRO color
        @SetPage MACRO pagenum
        @GetCsr MACRO pagenum
        @SetCsrPos MACRO column, row, pagenum
        @SetCsrSize MACRO first, last
        @GetCharAtr MACRO pagenum
        @PutCharAtr MACRO chr, atrib, pagenum, loops
        @PutChar MACRO chr, atrib, pagenum, loops
        @Scroll MACRO distance, atrib, upcol, uprow, dncol, dnrow
        @Cls MACRO pagenum

^

        .EXIT
        END
