@echo  off
echo.

rem // test access to required files
if exist float.ans           erase float.ans
if exist gradres.tmp      erase gradres.tmp
if exist testout          erase testout
if exist results          erase results
if exist results          goto  locked

if not exist float.asm       goto error3
if not exist float.exe       goto error2
if not exist gradfl.mod   goto error1
if not exist gradcpi.exe  goto error1
if not exist gradcpy.bat  goto error1
if not exist gradlog.exe  goto error1
if not exist gradres.exe  goto error1

rem // init grading count
if exist gradfl.cnt goto tmetest
call gradcpy.bat gradfl.mod gradfl.cnt
:tmetest

rem // init history log
if exist gradfl.tme goto endtme
echo Grading program history > gradfl.tme
:endtme

rem // update count and log
gradlog gradfl.cnt gradfl.tme p45 1 FLOAT
if errorlevel 4 goto locked

echo Float Grading System Version 4.0
echo Float Grading System Version 4.0 >> results

type  gradid.p45
type  gradid.p45  >> results

type  gradfl.tme  >> results

float             >> testout
gradcpi           >> results
gradcpi

rem Calculate the grade
gradres
type  gradres.tmp
type  gradres.tmp >> results
erase gradres.tmp
echo.
echo.             >> results

echo Building the file float.ans for electronic submission...
echo Building the file float.ans for electronic submission...  >> results
call gradcpy.bat results+float.asm float.ans
goto exit

:error1
echo.
echo The grading system has detected a problem.
echo Some of the required files are missing.
echo Try to re-copy all the grading files from the course locker.
echo If this fails then contact the instructor.
echo The grading system has detected a problem.                     >> results
echo Some of the required files are missing.                        >> results
echo Try to re-copy all the grading files from the course locker.   >> results
echo If this fails then contact the instructor.                     >> results
echo.
goto exit

:error2
echo.
echo The executable file 'float.exe' does not exist in this directory.
echo.
echo The executable file 'float.exe' does not exist in this directory. >> results
goto exit

:error3
echo.
echo The file 'float.asm' does not exist in this directory.
echo.
echo The file 'float.asm' does not exist in this directory.            >> results
goto exit

:locked
echo.
echo The grading system can not access its files.
echo Close this DOS window and open it again.
echo If that fails, then logout and login again.
echo.
goto exit

:exit
echo.
