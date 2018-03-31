@echo  off
echo.

rem // verify files exist and are valid
if not exist gradcpy.bat   goto error1
if not exist gradlogt.exe  goto error1
if not exist gradmark.exe  goto error1
if not exist linkdrvr.exe  goto error2

:tmetest
if exist gradlink.tme goto endtme
echo Grading and testing history log > gradlink.tme
:endtme

rem // test for marking run or user test
if not %1. == mark. goto usertest
gradmark gradlink.tme
goto exit

:usertest
rem // update the time
gradlogt gradlink.tme user_test testout
if errorlevel 4 goto locked

if exist testout erase testout
if exist okay    erase okay

echo Running test:
echo.
gradstok  0 > okay
linkdrvr  0 > testout
gradcomp
echo   'testout' is your program's output file
echo   'okay'    is the expected output file
if   not errorlevel 1 goto ok01

echo.
echo Your output does not seem correct.
echo Compare the file 'testout' to the file 'okay' to find the error
goto exit

:ok01
echo.
echo Your output is correct.
goto exit

:errcmd
echo.
echo To run a test type:
echo    testlink
echo.
echo To mark the program as working type:
echo    testlink  mark
echo.
goto   exit

:error1
echo.
echo The grading system has detected a problem.
echo Some of the required files are missing.
echo Try to re-copy all the grading files from the course locker.
echo If this fails then contact the instructor.
echo.
goto   exit

:error2
echo.
echo The executable file 'linkdrvr.exe' does not exist in this directory.
echo.
goto   exit

:locked
echo.
echo I can not access the required files.
echo Shutdown and reboot the system.
echo If the problem persists contact the instructor.
echo.
goto exit

:exit
echo.
