{ Unit to make assembly procedures available in Quick Pascal. }

UNIT    DEMO;

INTERFACE


CONST
	{ Constants }
	CR     = 13;            { ASCII code for Return  }
	ESCAPE = 27;            { ASCII code for Esc key }
	MDA    = 0;             { Adapter constants      }
	CGA    = 1;
	MCGA   = 2;
	EGA    = 3;
	VGA    = 4;
	MONO   = 0;             { Display constants      }
	COLOR  = 1;

{$A- Record members at 1-byte boundaries }

TYPE

	{ Video configuration record }
	vid_config = RECORD
		vmode    : BYTE;        { Current mode           }
		dpage    : BYTE;        { Current display page       }
		rows     : BYTE;        { Number of display rows - 1     }
		display  : BYTE;        { Either MONO or COLOR       }
		adapter  : BYTE;        { Adapter code           }
		CGAvalue : BYTE;        { Enable value for CGA       }
		sgmnt    : WORD;        { Video segment with page offset }
	END;

	{ Disk statistics returned from GetDiskSize procedure }
	disk_stat = RECORD
		total : WORD;           { total clusters      }
		avail : WORD;           { available clusters  }
		sects : WORD;           { sectors per cluster }
		bytes : WORD;           { bytes per sector    }
	END;

	{ File information returned from FindFirst procedure  }
	file_info = RECORD
		pad    : STRING[21];    { pad to 43 bytes     }
		attrib : BYTE;          { file attribute      }
		time   : INTEGER;       { file time           }
		date   : INTEGER;       { file date           }
		size   : LONGINT;       { file size           }
		name   : STRING[13];    { file name           }
	END;

	{ Procedure prototypes from COMMON.ASM }
	PROCEDURE GetVidConfig;
	PROCEDURE StrWrite( row : INTEGER; col : INTEGER; str : CSTRING );
	PROCEDURE ClearBox( attr : WORD;
						row1 : INTEGER; col1 : INTEGER;
						row2 : INTEGER; col2 : INTEGER );
	FUNCTION GetVer : INTEGER;
	FUNCTION SetCurPos( row : INTEGER; col : INTEGER ) : INTEGER;

	{ Procedure prototypes from MISC.ASM }
	FUNCTION WinOpen( row1 : INTEGER; col1 : INTEGER;
					  row2 : INTEGER; col2 : INTEGER;
					  attr : WORD ) : INTEGER;
	PROCEDURE WinClose( addr : WORD );
	PROCEDURE SetCurSize( scan1 : WORD; scan2 : WORD );
	FUNCTION GetCurSize : WORD ;
	FUNCTION GetCurPos : WORD ;
	FUNCTION GetShift : WORD ;
	FUNCTION GetKeyClock( row : INTEGER; col : INTEGER ) : INTEGER;
	FUNCTION GetMem : LONGINT;
	FUNCTION VeriPrint : INTEGER;
	FUNCTION VeriAnsi : INTEGER;
	FUNCTION VeriCop : INTEGER;
	FUNCTION SetLineMode( line : INTEGER ) : INTEGER;
	PROCEDURE Pause( duration : WORD );
	PROCEDURE Sound( freq : WORD; duration : WORD );
	PROCEDURE WriteTTY( VAR str : CSTRING ; icolor : WORD );
	PROCEDURE Colors( logic : INTEGER; attr : WORD;
					  row1 : INTEGER; col1 : INTEGER;
					  row2 : INTEGER; col2 : INTEGER );
	PROCEDURE BinToHex( num : INTEGER; VAR hexstr : CSTRING );

	{ Procedure prototypes from MATH.ASM }
	FUNCTION  AddLong(  long1 : LONGINT; long2 : LONGINT ) : LONGINT;
	FUNCTION  SubLong(  long1 : LONGINT; long2 : LONGINT ) : LONGINT;
	FUNCTION  ImulLong( long1 : LONGINT; long2 : LONGINT ) : LONGINT;
	{ FUNCTION *MulLong(  long1 : LONGINT; long2 : LONGINT ) : LONGINT; }
	FUNCTION  DivLong(  long1 : LONGINT; short2 : INTEGER;
								VAR remn : INTEGER ) : INTEGER;
	FUNCTION IdivLong( long1 : LONGINT; short2 : INTEGER;
								VAR remn : INTEGER ) : INTEGER;
	FUNCTION Quadratic( a: SINGLE; b : SINGLE; c : SINGLE;
								 VAR r1 : SINGLE; VAR r2 : SINGLE ) : INTEGER;

	{ Procedure prototypes from FILE.ASM }
	PROCEDURE ChangeDrive( drive : INTEGER );
	PROCEDURE GetDiskSize( drive : INTEGER; VAR disk: disk_stat );
	FUNCTION ReadCharAttr( VAR attr : INTEGER ) : INTEGER;
	FUNCTION GetCurDir( VAR spec : CSTRING ) : INTEGER;
	FUNCTION GetCurDisk : INTEGER;
	FUNCTION CopyFile(      imode : INTEGER;
					   VAR fspec1 : CSTRING;
					   VAR fspec2 : CSTRING ) : INTEGER;
	FUNCTION DelFile( fspec : CSTRING ) : INTEGER;
	FUNCTION MakeDir( pspec : CSTRING ) : INTEGER;
	FUNCTION RemoveDir( pspec : CSTRING ) : INTEGER;
	FUNCTION ChangeDir( pspec : CSTRING ) : INTEGER;
	FUNCTION GetAttribute( fspec : CSTRING ) : INTEGER;
	FUNCTION SetAttribute( attr : INTEGER; fspec : CSTRING ) : INTEGER;
	FUNCTION RenameFile( fspec1 : CSTRING; fspec2 :CSTRING ) : INTEGER;
	FUNCTION GetFileTime( handle : INTEGER; str : CSTRING ) : INTEGER;
	FUNCTION FindFirst( attr : WORD; fspec : CSTRING; VAR finfo : file_info ) : INTEGER ;
	FUNCTION FindNext( VAR finfo : file_info ) : INTEGER;
	FUNCTION UniqueFile( attr : WORD; fspec : CSTRING ) : INTEGER;
	FUNCTION OpenFile( access : INTEGER; fspec : CSTRING ) : INTEGER;
	FUNCTION CloseFile( handle : INTEGER ) : INTEGER;
	FUNCTION ReadFile( handle : INTEGER; len : INTEGER; pbuff :CSTRING ) : INTEGER;
	FUNCTION GetStr( bufstr : CSTRING; maxlen : INTEGER ): INTEGER;
	{ FUNCTION char *StrCompare( str1 : CSTRING; str2 : CSTRING;  len : INTEGER );
	FUNCTION char *StrFindChar( ichar : BYTE; str : CSTRING; INTEGER direct );
	}

	{ Procecedure prototype for internal procedure. }
	PROCEDURE clear_scrn( attr : WORD; row1 : INTEGER; row2 : INTEGER );

IMPLEMENTATION

VAR
	vconfig : vid_config; 	{ Record for video configuration }

{$L COMMON.OBJ}
	{ Procedure prototypes from COMMON.ASM }
	PROCEDURE GetVidConfig; EXTERNAL;
	PROCEDURE StrWrite( row : INTEGER; col : INTEGER; str : CSTRING ); EXTERNAL;
	PROCEDURE ClearBox( attr : WORD;
						row1 : INTEGER; col1 : INTEGER;
						row2 : INTEGER; col2 : INTEGER ); EXTERNAL;
	FUNCTION GetVer : INTEGER;
	FUNCTION SetCurPos( row : INTEGER; col : INTEGER ) : INTEGER;

{$L MISC.OBJ}
	{ Procedure prototypes from MISC.ASM }
	FUNCTION WinOpen( row1 : INTEGER; col1 : INTEGER;
					  row2 : INTEGER; col2 : INTEGER;
					  attr : WORD ) INTEGER; EXTERNAL;
	PROCEDURE WinClose( addr : WORD );
	PROCEDURE SetCurSize( WORD scan1; WORD scan2 );
	FUNCTION WORD GetCurSize : WORD ;
	FUNCTION WORD GetCurPos : WORD ;
	FUNCTION WORD GetShift : WORD ;
	FUNCTION INTEGER GetKeyClock( row : INTEGER; col : INTEGER );
	FUNCTION GetMem : LONGINT;
	FUNCTION VeriPrint : INTEGER;
	FUNCTION VeriAnsi : INTEGER;
	FUNCTION VeriPrint : INTEGER;
	FUNCTION SetLineMode( line : INTEGER ) : INTEGER;
	PROCEDURE Pause( duration : WORD );
	PROCEDURE Sound( freq : WORD; duration : WORD );
	PROCEDURE WriteTTY( str : CSTRING; icolor : WORD );
	PROCEDURE Colors( logic : INTEGER; attr : WORD;
					  row1 : INTEGER; col1 : INTEGER;
					  row2 : INTEGER; col2 : INTEGER; attr : WORD );
	PROCEDURE BinToHex( num : INTEGER; hexstr : CSTRING );

{$L MATH.OBJ}

	{ Procedure prototypes from MATH.ASM }
	FUNCTION LONGINT  AddLong(  long1 : LONGINT; long2 : LONGINT ); EXTERNAL;
	FUNCTION LONGINT  SubLong(  long1 : LONGINT; long2 : LONGINT ); EXTERNAL;
	FUNCTION LONGINT  ImulLong( long1 : LONGINT; long2 : LONGINT ); EXTERNAL;
	FUNCTION LONGINT *MulLong(  long1 : LONGINT; long2 : LONGINT ); EXTERNAL;
	FUNCTION INTEGER  DivLong(  long1 : LONGINT; short2 : INTEGER;
								VAR remn : INTEGER ); EXTERNAL;
	FUNCTION INTEGER  IdivLong( long1 : LONGINT; short2 : INTEGER;
								VAR remn : INTEGER ); EXTERNAL;
	FUNCTION INTEGER  Quadratic( a: SINGLE; b : SINGLE; c : SINGLE;
								 VAR r1 : SINGLE; VAR r2 : SINGLE ); EXTERNAL;

{$L FILE.OBJ}

	{ Procedure prototypes from FILE.ASM }
	PROCEDURE  ChangeDrive( drive : INTEGER ); EXTERNAL;
	PROCEDURE  GetDiskSize( drive : INTEGER; VAR disk : disk_stat ); EXTERNAL;
	PROCEDURE  GetVidConfig; EXTERNAL;
	FUNCTION ReadCharAttr( VAR attr : INTEGER ) : INTEGER; EXTERNAL;
	FUNCTION GetCurDir( VAR spec : CSTRING ) : INTEGER; EXTERNAL;
	FUNCTION GetCurDisk : INTEGER; EXTERNAL;
	FUNCTION CopyFile(      imode : INTEGER;
					   VAR fspec1 : CSTRING;
					   VAR fspec2 : CSTRING ) : INTEGER; EXTERNAL;
	FUNCTION DelFile( fspec : CSTRING ) : INTEGER; EXTERNAL;
	FUNCTION MakeDir( pspec : CSTRING ) : INTEGER; EXTERNAL;
	FUNCTION RemoveDir( pspec : CSTRING ) : INTEGER; EXTERNAL;
	FUNCTION ChangeDir( pspec : CSTRING ) : INTEGER; EXTERNAL;
	FUNCTION GetAttribute( fspec : CSTRING ) : INTEGER; EXTERNAL;
	FUNCTION SetAttribute( attr : INTEGER; char *fspec ) : INTEGER; EXTERNAL;
	FUNCTION RenameFile( char *fspec1; char *fspec2 ) : INTEGER; EXTERNAL;
	FUNCTION GetFileTime( handle : INTEGER; char *str ) : INTEGER; EXTERNAL;
	FUNCTION FindFirst( attr : WORD; char *fspec; VAR finfo : file_info ) : INTEGER ; EXTERNAL;
	FUNCTION FindNext( VAR finfo : file_info ) : INTEGER; EXTERNAL;
	FUNCTION UniqueFile( attr : WORD; char *fspec ) : INTEGER; EXTERNAL;
	FUNCTION OpenFile( access : INTEGER; char *fspec ) : INTEGER; EXTERNAL;
	FUNCTION CloseFile( handle : INTEGER ) : INTEGER; EXTERNAL;
	FUNCTION ReadFile( handle : INTEGER; len : INTEGER; char *pbuff ) : INTEGER; EXTERNAL;
	FUNCTION SetCurPos( row : INTEGER; col : INTEGER ) : INTEGER; EXTERNAL;
	FUNCTION GetStr( char *bufstr; INTEGER maxlen ): INTEGER; EXTERNAL;
	FUNCTION char *StrCompare( char *str1; char *str2; INTEGER len ); EXTERNAL;
	FUNCTION char *StrFindChar( char ichar; char *str; INTEGER direct ); EXTERNAL;

	{ Procecedure prototype for internal procedure. }
	PROCEDURE clear_scrn( attr, row1, row2 );

PROCEDURE clear_scrn( attr : WORD, row1 : INTEGER, row2 : INTEGER );
BEGIN
	ClearBox( attr, row1, 0, row2, 79 );
END;

END.
