REM Build file for MASM 6.0 help
d:

REM Build ALANG.HLP
cd \masm60\help\examples
start /fs /c ssync >c:\batch\syncout 2>c:\batch\syncerr
cd ..
start /fs /c ssync >c:\batch\syncout 2>C:\batch\syncerr
REM Build ALANGNDX.SRC
REM hit /a /talanghdr.ndx *.src alangndx.src >alangndx.err
hpp *.src alang.tmp > alang.log
HELPMAKE /E /A: /t /V3 /S2 /w80 /Oalang.hlp alang.tmp > alang.hmk 2> alang.err

REM Build ML.HLP
cd \masm60\help\ml
start /c ssync *.* >c:\batch\syncout 2>c:\batch\syncerr
REM Build MLNDX.SRC
REM hit /a /tmlhdr.ndx *.src mlndx.src >mlndx.err
cat ml.src a1xxx.src a2xxx.src a4xxx.src hi1xxx.src hi2xxx.src hi4xxx.src masmopt.src mlndx.src >temp.src
hpp temp.src ml.tmp > ml.log
del temp.src
HELPMAKE /E /A: /t /V3 /S2 /w80 /Oml.hlp ml.tmp > ml.hmk 2> ml.err

REM Send file sizes
echo off
cd \masm60\help
dir alang.hlp >temp.dir
dir ml\ml.hlp >>temp.dir
type c:\batch\buildm.txt temp.dir >mess.out

net send jonka <mess.out
REM net send chriscr <mess.out

del mess.out
del temp.dir

REM Test links
helptree alang.tmp > alang.out
helptree ml\ml.tmp > ml\ml.out
linktest
REM tl

REM Copy to net
cd p:\masm60\help\test
copy alang.hlp p:
copy ml\ml.hlp p:

REM Copy indexes (indices) to Laura's directory
cd p:\exchange\a-anitaa
copy alangndx.src p:
copy ml\mlndx.src p:

REM Copy to \HELPFILE and clean up.
copy alang.hlp d:\HELPFILE
copy ml\ml.hlp d:\HELPFILE
REM lang.tmp ml\ml.tmp
REM del alang.out ml\ml.out
del alang.hlp ml\ml.hlp
