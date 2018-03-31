        .MODEL  small, pascal

        INCLUDE macros.inc

        .DATA

TECHOF  EQU     1
TFORL   EQU     1
;TSAVE   EQU     1
;TPUSH   EQU     1

IFDEF   TECHOF
msg     BYTE    "This is a test$"

        echof  <value $ is $>, (LENGTH msg), %(LENGTH msg)
        echof  <value $ is $ bytes>, (LENGTH msg), %(LENGTH msg)
        echof  <value $ is $ bytes>, (LENGTH msg), %(LENGTH msg), 6
        echof  <value $ is $>, (LENGTH msg), %(LENGTH msg), 6
        ;echof  <The value of $ is $>, (TYPE msg), %(TYPE msg)
        ;echof  <The value of $ is $>, (SIZE msg), %(SIZE msg)
        ;echof  <The value of $ is $>, (OPATTR msg), %(OPATTR msg)
ENDIF

comment ^
IFDEF   TFORL
fortest MACRO   args:VARARG

%   ECHO Number of arguments is: @ArgCount( args )

%   ECHO Argument 3 is: @ArgI( 3, args )

%   ECHO Arguments in reverse order: @ArgRev( args )

    FOR  arg, @ArgRev( args )
        ECHO arg
    ENDM
ENDM

        fortest 1,2,3,4
        fortest one, two, three
ENDIF
^
        .STACK
        .DATA

        .CODE
        .STARTUP

IFDEF   TSAVE
        @SaveRegs  ax, bx, dx

%       ECHO    regpushed

        @RestoreRegs
ENDIF

IFDEF   TPUSH
        @PushAll
        @PopAll
ENDIF
        .EXIT
        END
