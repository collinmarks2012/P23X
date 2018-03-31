@echo  off
echo.

rem // verify the input and output file exist
if not exist gradlogt.exe  goto error1
if not exist gradmark.exe  goto error1
if not exist key.exe       goto error2

:tmetest
if exist gradkey.tme goto endtme
echo Grading and testing history log > gradkey.tme
:endtme

rem // test for marking run or user test or nt test
if %1. == mark. goto mark
if %1. == nt.   goto nt
if %1. == .     goto user
goto errcmd

:nt
rem // update the time
gradlogt gradkey.tme nt test
if errorlevel 4 goto locked
echo We are now going to test for the NT bug.
echo If you are running under Windows-NT,
echo   and the system hangs, and you
echo   need to Ctrl-Break out, then your
echo   code probably has the NT bug.
echo.
echo Running your key.exe now.
echo testing. > gradkey.nt1
key < gradkey.nt1 > gradkey.nt2
echo If the code made it to here on its own,
echo then your key.exe did not hang the system.
if exist gradkey.nt1 erase gradkey.nt1
if exist gradkey.nt2 erase gradkey.nt2
goto exit

:mark
gradmark gradkey.tme
goto exit

:user
rem // update the time
gradlogt gradkey.tme keyboard test
if errorlevel 4 goto locked

rem // run the test
echo.Enter data...
key
echo.
goto exit

:error1
echo.
echo The grading system has detected a problem.
echo Some of the required files are missing.
echo Try to re-copy all the grading files from the course locker.
echo If this fails then contact the instructor.
echo.
goto exit

:error2
echo.
echo The executable file 'key.exe' does not exist in this directory
echo.
goto exit

:errcmd
echo.
echo Command        Type of test
echo ------------   ----------------------------
echo teskey         Run a test from the keyboard
echo testkey mark   Mark the program as working
echo testkey nt     Test for the NT bug
echo.
goto exit

:locked
echo.
echo I can not access the required files.
echo - Close this DOS window and open it again.
echo - If that does not work then logout and login again
echo If the problem persists contact the instructor.
echo.
goto exit

:exit
echo.
