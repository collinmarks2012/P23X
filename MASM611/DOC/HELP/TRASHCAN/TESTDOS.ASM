        .MODEL  small, pascal, DOS
        INCLUDE DOS.INC

PVOID   TYPEDEF      PTR
FPVOID  TYPEDEF FAR  PTR
NPVOID  TYPEDEF NEAR PTR

        .STACK
        .DATA
handle  WORD    0
d       DWORD   0
msg     BYTE    "This is a test$"
array   BYTE    40 DUP (?)
ofname  BYTE    "test.tmp", 0
nfname  BYTE    "ntest.tmp", 0
path    BYTE    "new", 0
p       PVOID   0
np      NPVOID  0
fp      FPVOID  0

        .CODE
        .STARTUP

        @GetChar 1, 1
        @GetChar 1, 0
        @GetChar 0, 0
        @GetChar 0, 1
        @GetChar 1, 0, 1
        @GetChar 1, 0, 1

        @GetStr array, 0, 80

        @GetVer
        mov     dx, ax
        add     dl, '0'
        shr     dh, 1
        shr     dh, 1
        shr     dh, 1
        shr     dh, 1
        add     dh, '0'

        @ShowChar dl, '.', dh, 13, 10

        @ShowChar 'a', 'b', 'c', 'd', 13, 10

        @PrtChar  'a', 'b', 'c', 'd'

        @ShowStr msg

        @Read array, 5

        @Write msg, (LENGTH msg) - 1

        @MkDir path
        @ChDir path

        @GetDir array, 0

        @MakeFile ofname, 0

        .IF !carry
        mov     handle, ax

        @Write msg, (LENGTH msg) - 1, ax

        @CloseFile handle

        .ENDIF

        @OpenFile ofname
        .IF     !carry
        mov     handle, ax

        ;@GetFileSize handle

        ;@Read array, (LENGTH msg) - 1, handle

        ;@MovePtrAbs handle, 0

        ;@Read array, 3, handle

        ;@MovePtrRel handle, 2

        ;@Read array, 4, handle

        @CloseFile handle
        .ENDIF

        @MoveFile ofname, nfname

        @DelFile nfname

        @RmDir path

        @GetDrv
        mov     cl, al
        @ShowChar cl, 13, 10
        @SetDrv 2
        @GetDrv
        @ShowChar al, 13, 10
        @SetDrv cl

        @ChkDrv

        COMMENT ^

        @FreeBlock MACRO segmnt
        @GetBlock MACRO graphs:REQ
        @ModBlock MACRO graphs:REQ, segmnt

        @GetDate
        @SetDate MACRO month:REQ, day:REQ, year:REQ
        @GetTime
        @SetTime MACRO hour:REQ, minutes:REQ, seconds:REQ, hundredths:REQ

        @GetInt MACRO   interrupt:REQ
        @SetInt MACRO interrupt:REQ, vector:REQ, segmnt

        ; @GetFirst MACRO path:REQ, atrib, segmnt, buffer, buffseg
        ; @GetNext MACRO
        ; @GetDTA MACRO
        ; @SetDTA MACRO buffer:REQ, segmnt
        ; @TSR MACRO paragraphs:REQ, return

        ^

        @Exit 0
        END
