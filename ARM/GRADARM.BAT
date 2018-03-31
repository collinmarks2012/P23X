@echo off
echo.

rem // test access to required files
if exist arm.ans     erase arm.ans
if exist gradres.tmp erase gradres.tmp
if exist results     erase results
if exist results     goto  locked

rem // assure all executable files exist and are valid
if not exist gradcomp.exe goto error
if not exist gradarm.in   goto error
if not exist gradarm.mod  goto error
if not exist gradarm.ok   goto error
if not exist gradlog.exe  goto error
if not exist gradmarm.exe goto error
if not exist gradres.exe  goto error
if not exist armkey.s     goto error2
if not exist key.out      goto error3

rem // init grading count
if exist gradarm.cnt goto tmetest
call gradcpy.bat gradarm.mod gradarm.cnt

:tmetest
rem // init history log
if exist gradarm.tme goto endtme
echo Grading program history > gradarm.tme
:endtme

rem // update count and log
gradlog gradarm.cnt gradarm.tme p50 2
if errorlevel 4 goto locked

:nrun2
echo ARM Grading System Version 4.1
echo ARM Grading System Version 4.1 >> results

type   gradid.p50
type   gradid.p50  >> results
type   gradarm.tme >> results

echo Comparing your program's key.out to the expected output
echo Comparing your program's key.out to the expected output  >> results

call gradcpy.bat gradarm.ok      okay
call gradcpy.bat key.out         testout
gradcomp
if not errorlevel 1 goto okay

echo.
echo There is an error in the output of the arm program.
echo The input is in file:             gradarm.in
echo The correct output is in file:    okay
echo Your program's output is in file: key.out
echo.
echo ++ Grade ++    0 = Points earned for correct answers.
echo.

echo.                                                         >> results
echo There is an error in the output of the arm program.      >> results
echo The input is in file:             gradarm.in             >> results
echo The correct output is in file:    okay                   >> results
echo Your program's output is in file: KEY.OUT                >> results
echo.                                                         >> results
echo ++ Grade ++    0 = Points earned for correct answers.    >> results
echo.                                                         >> results

rem Calculate the grade
gradres
type  gradres.tmp
type  gradres.tmp >> results
erase gradres.tmp
echo. >> results
echo Building the file arm.ans for electronic submission...
echo Building the file arm.ans for electronic submission... >> results
call gradcpy.bat results+armkey.s arm.ans
goto exit2

:error2
echo.
echo The source assembler file armkey.s does not exist in this directory
echo.
echo The source assembler file armkey.s does not exist in this directory >> results
goto exit

:error3
echo.
echo The output file key.out does not exist in this directory
echo.
echo The output file key.out does not exist in this directory >> results
goto exit

:okay
echo Test ran correctly.
Echo ++ Grade ++   60 = Points earned for correct answers.
echo.
echo Test ran correctly.                                          >> results
Echo ++ Grade ++   60 = Points earned for correct answers.        >> results
echo.                                                             >> results

rem Grade efficiency
gradmarm armkey.s
gradmarm armkey.s >> results
echo.
echo. >> results

rem Grade documentation
graddoc armkey.s >> results
graddoc armkey.s
echo.
echo. >> results

rem Calculate the grade
gradres
type  gradres.tmp
type  gradres.tmp >> results
erase gradres.tmp

echo Building the file arm.ans for electronic submission...
echo Building the file arm.ans for electronic submission... >> results
call gradcpy.bat results+armkey.s arm.ans
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
:exit2
if exist gradjunk erase gradjunk
echo ************************************************************************
echo ***** In case they scrolled by too quickly ... all messages        *****
echo ***** written to the display were also written to the RESULTS file *****
echo ************************************************************************
