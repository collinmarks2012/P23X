#include <string.h>
#include <stream.hxx>
#include <stdlib.h>

void Quit( char* pch );
int GetNext( istream fileIn );
int SkipToFirst( istream fileIn );

#define MAXCOL 120
char achT[MAXCOL];
enum BOOL { FALSE, TRUE };

void main( int argc, char *argv[] )
{

    if( argc < 2 )
        Quit( "SYNTAX: XSTRIP infile" );

    filebuf bufIn;

    if( bufIn.open( argv[1], input ) == 0 )
        Quit( "Can't open input file" );

    istream fileIn( &bufIn );

    /* Skip initial lines to first header block. */
    if( !SkipToFirst( fileIn ) )
        Quit( "Not a valid demo file" );

    /* Parse each header block and */
    while( GetNext( fileIn ) )
        ;

    exit( 0 );
}

int SkipToFirst( istream fileIn )
{

    do
    {
        char* pch;
        for( pch = achT; *(pch - 1) != '\n'; pch++ )
            fileIn.get( *pch );
            if( fileIn.eof() )
                return 0;
        *pch = '\0';

    } while( strncmp( achT, ";*", 2 ) );
    return 1;
}

int GetNext( istream fileIn )
{
    char    achName[15], *pch;

    strncpy( achName, achT + 3, 8 );
    achName[8] = '\0';
    pch = strchr( achName, ' ' );
    if( pch != NULL )
        *pch = '\0';

    strcat( achName, ".asx" );

    filebuf bufOut;
    if( bufOut.open( achName, output ) == 0 )
        Quit( "Can't open output file" );
    ostream fileOut( &bufOut );

    int fInComment = TRUE;
    while( 1 )
    {
        fileOut << achT;

        for( pch = achT; *(pch - 1) != '\n'; pch++ )
        {
            fileIn.get( *pch );
            if( fileIn.eof() )
            {
                *pch = '\0';
                fileOut << achT;
                return 0;
            }
        }
        *pch = '\0';

        // fileIn.get( achT, MAXCOL - 1 );

        switch( fileIn.rdstate() )
        {
            case _eof:
                return 0;
                // Quit( "Finished processing file" );
            case _bad:
            case _fail:
                Quit( "File read failed" );
            default:
                break;
        }
        if( fInComment && strncmp( achT, ";*", 2 ) )
            fInComment = FALSE;
        if( !fInComment && !strncmp( achT, ";*", 2 ) )
            return 1;
    }
}

/* Quit with message */
void Quit( char* pch )
{
    cout << pch << "\n";
    exit( 1 );
}
