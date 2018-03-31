@echo    off
echo.

rem // test access to required files
if exist results  erase results
if exist pi.ans   erase pi.ans
if exist results  goto  locked
if exist pi.ans   goto  locked

rem // assure all executable files exist and are valid
if not exist extend.asm    goto error3
if not exist graddrvr.exe  goto error2
if not exist gradcpy.bat   goto error1
if not exist gradgtl.exe   goto error1
if not exist gradlog.exe   goto error1
if not exist gradlogt.exe  goto error1
if not exist gradmark.exe  goto error1
if not exist gradres.exe   goto error1

rem // init grading count
if exist gradpi.cnt goto tmetest
call gradcpy.bat gradpi.mod gradpi.cnt

:tmetest
rem // init history log
if exist gradpi.tme goto endtme
echo Grading program history > gradpi.tme
:endtme
if %1. == s. goto skip
gradgtl gradpi.tme
if errorlevel 4 goto exit
:skip

rem // update count and log
gradlog gradpi.cnt gradpi.tme p27 2
if errorlevel 4 goto locked

echo PI Grading System Version 4.0
echo PI Grading System Version 4.0 >> results

type gradid.p27 >> results
type gradpi.tme >> results

rem // run tests
echo Calcuating PI ... this may take a few minutes
echo Hopefully you have thoroughly tested addx and divx
echo.
graddrvr.exe b >> results
if     errorlevel 5 goto calcgrad
if not errorlevel 4 goto calcgrad

rem Grade documentation
graddoc extend.asm
echo.
echo.                                                     >> results
graddoc extend.asm                                        >> results
echo.                                                     >> results

:calcgrad
type results
rem Calculate the grade
gradres
type  gradres.tmp
type  gradres.tmp >> results
erase gradres.tmp

echo Building the file pi.ans for electronic submission...
echo Building the file pi.ans for electronic submission... >> results
echo.                                                      >> results
call gradcpy.bat results+extend.asm pi.ans
goto exit

:error1
echo.
echo The grading system has detected a problem.
echo Some of the required files are missing.
echo Try to re-copy all the grading files from the course locker.
echo If this fails then contact the instructor.
echo.

echo.                                                             >> results
echo The grading system has detected a problem.                   >> results
echo Some of the required files are missing.                      >> results
echo Try to re-copy all the grading files from the course locker. >> results
echo If this fails then contact the instructor.                   >> results
echo.                                                             >> results
goto exit

:error2
echo.
echo The executable file graddrvr.exe does not exist in this directory
echo.
echo *******************************************************************
echo ***         You must relink graddrvr.obj and extend.obj         ***
echo *** after testing to assure you are grading your latest version ***
echo *******************************************************************
echo.

echo.                                                                    >> results
echo The executable file graddrvr.exe does not exist in this directory   >> results
echo.                                                                    >> results
echo ******************************************************************* >> results
echo ***         You must relink graddrvr.obj and extend.obj         *** >> results
echo *** after testing to assure you are grading your latest version *** >> results
echo ******************************************************************* >> results
echo.                                                                    >> results
goto exit

:error3
echo.
echo The source assembler file extend.asm does not exist in this directory.
echo This file is needed to continue testing.
echo.

echo.                                                                       >> results
echo The source assembler file extend.asm does not exist in this directory. >> results
echo This file is needed to continue testing.                               >> results
echo.                                                                       >> results
goto exit

:locked
echo.
echo The grading system can not access its files.
echo Shutdown and reboot the system.
echo.
goto exit

:exit
if exist gradjunk erase gradjunk
echo ************************************************************************
echo ***** In case they scrolled by too quickly ... all messages        *****
echo ***** written to the display were also written to the RESULTS file *****
echo ************************************************************************
