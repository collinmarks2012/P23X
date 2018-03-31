@echo off
echo.

rem // test access to required files
if exist key.ans     erase key.ans
if exist gradres.tmp erase gradres.tmp
if exist results     erase results
if exist results     goto  locked

rem // assure all executable files exist and are valid
if not exist gradcomp.exe goto error
if not exist graddoc.exe  goto error
if not exist gradkey.in   goto error
if not exist gradgtl.exe  goto error
if not exist gradkey.mod  goto error
if not exist gradkey.ok   goto error
if not exist gradlog.exe  goto error
if not exist gradmkey.exe goto error
if not exist gradres.exe  goto error
if not exist key.asm      goto error2
if not exist key.exe      goto noexe

rem // init grading count
if exist gradkey.cnt goto tmetest
call gradcpy.bat gradkey.mod gradkey.cnt

:tmetest
rem // init history log
if exist gradkey.tme goto endtme
echo Grading program history > gradkey.tme
:endtme
if %1. == s. goto skip
gradgtl gradkey.tme
if errorlevel 4 goto exit
:skip

rem // update count and log
gradlog gradkey.cnt gradkey.tme p00 1
if errorlevel 4 goto locked

:nrun2
echo Key Grading System Version 4.1
echo Key Grading System Version 4.1 >> results

type   gradid.p00
type   gradid.p00  >> results
type   gradkey.tme >> results

echo Running test
echo Running test  >> results

call gradcpy.bat gradkey.ok      okay
key  < gradkey.in > testout
gradcomp
if not errorlevel 1 goto okay

echo.
echo There is an error in the output of the key program.
echo The input is in file:             gradkey.in
echo The correct output is in file:    okay
echo Your program's output is in file: testout
echo.
echo ++ Grade ++    0 = Points earned for correct answers.
echo.

echo.                                                         >> results
echo There is an error in the output of the key program.      >> results
echo The input is in file:             gradkey.in             >> results
echo The correct output is in file:    okay                   >> results
echo Your program's output is in file: testout                >> results
echo.                                                         >> results
echo ++ Grade ++    0 = Points earned for correct answers.    >> results
echo.                                                         >> results

rem Calculate the grade
gradres
type  gradres.tmp
type  gradres.tmp >> results
erase gradres.tmp
echo. >> results
echo Building the file key.ans for electronic submission...
echo Building the file key.ans for electronic submission... >> results
call gradcpy.bat results+key.asm key.ans
goto exit2

:noexe
echo The executable file key.exe does not exist in this directory
echo The executable file key.exe does not exist in this directory  >> results
goto exit

:error2
echo.
echo The source assembler file key.asm does not exist in this directory
echo.
echo The source assembler file key.asm does not exist in this directory >> results
goto exit

:okay
echo Test ran correctly.
Echo ++ Grade ++   60 = Points earned for correct answers.
echo.
echo Test ran correctly.                                          >> results
Echo ++ Grade ++   60 = Points earned for correct answers.        >> results
echo.                                                             >> results

rem Grade efficiency
gradmkey key.asm
gradmkey key.asm >> results
echo.
echo. >> results

rem Grade documentation
graddoc key.asm >> results
graddoc key.asm
echo.
echo. >> results

rem Calculate the grade
gradres
type  gradres.tmp
type  gradres.tmp >> results
erase gradres.tmp

echo Building the file key.ans for electronic submission...
echo Building the file key.ans for electronic submission... >> results
call gradcpy.bat results+key.asm key.ans
goto exit

:error
echo Some of the required grading files are missing.
echo Re-copy all the files from the course locker and try again.
echo Some of the required grading files are missing.              >> results
echo Re-copy all the files from the course locker and try again.  >> results
goto exit

:locked
if exist results erase results
echo.
echo The grading system cannot access its files.
echo Close this DOS window and open it again.
echo.
goto exit

:exit
if exist okay    erase okay
if exist testout erase testout
:exit2
if exist gradjunk erase gradjunk
echo ************************************************************************
echo ***** In case they scrolled by too quickly ... all messages        *****
echo ***** written to the display were also written to the RESULTS file *****
echo ************************************************************************
