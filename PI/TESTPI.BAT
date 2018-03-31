@echo  off
echo.

if not exist gradlogt.exe  goto  error1
if not exist gradmark.exe  goto  error1
if not exist testdrvr.exe  goto  error2
if     exist graddrvr.exe  erase graddrvr.exe

rem // verify the user typed the correct command
rem // if this is a marking run then do not test files
if %1. == mark.  goto tmetest
if %1. == .      goto errcmd
if not exist %1  goto errin

:tmetest
if exist gradpi.tme goto endtme
echo Grading and testing history log > gradpi.tme
:endtme

rem // test for marking run or user test
if not %1. == mark. goto usertest
gradmark gradpi.tme
goto exit

:usertest
rem // update the time
gradlogt gradpi.tme %1 TESTOUT
if errorlevel 4 goto locked

:addeof
call gradcpy.bat %1+eof grad.tmp
rem // run the test
echo Running the tests. Output is in the file named testout.
testdrvr < grad.tmp > testout
goto exit

:errcmd
echo.
echo Command format is:  testpi  inputfile
echo.
goto   exit

:errin
echo.
echo The input file specified: %1 does not exist.
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
echo The executable file testdrvr.exe does not exist in this directory.
echo.
goto   exit

:locked
echo.
echo I can not access the required files.
echo Shutdown and reboot the system.
echo.
goto exit

:exit
if exist grad.tmp erase grad.tmp
if exist gradjunk erase gradjunk
:wt if not exist testout goto wt
echo.
