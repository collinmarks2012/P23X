@echo  off
echo.

rem // test access to required files
if exist multiply.ans erase multiply.ans
if exist gradres.tmp  erase gradres.tmp
if exist gradtemp     erase gradtemp
if exist testout      erase testout
if exist okay         erase okay
if exist results      erase results
if exist results      goto  locked

if not exist multiply.asm goto error3
if not exist multdrvr.exe goto error2
if not exist gradcomp.exe goto error1
if not exist gradcpy.bat  goto error1
if not exist graddoc.exe  goto error1
if not exist gradgtl.exe  goto error1
if not exist gradlog.exe  goto error1
if not exist gradmult.mod goto error1
if not exist gradres.exe  goto error1

rem // update history log
if exist gradmult.cnt goto tmetest
call gradcpy.bat gradmult.mod gradmult.cnt

:tmetest
if exist gradmult.tme goto endtme
echo Grading and testing history log > gradmult.tme
:endtme
rem gradgtl gradmult.tme
rem if errorlevel 4 goto exit

:run
rem // update count and log
gradlog gradmult.cnt  gradmult.tme  p37  2
if errorlevel 4 goto locked

echo Multiply Grading System Version 4.0
echo Multiply Grading System Version 4.0 >> results

type  gradid.p37
type  gradid.p37   >> results
type  gradmult.tme >> results


:t0001
gradmuok  0 > okay
multdrvr  0 > testout
gradcomp
if       not errorlevel 1 goto ok0001
 echo.
 echo    Error encountered in test 0001
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo    Compare the file 'testout' to the file 'okay' to find the error
 echo.
 echo ++ Grade ++    0 = Points earned for correct answers.
 echo.
 echo.                                                                   >> results
 echo    Error encountered in test 0001                                  >> results                 >> results
 echo    testout     is your program's output file                       >> results
 echo    okay        is the expected output file                         >> results
 echo    Compare the file 'testout' to the file 'okay' to find the error >> results
 echo.                                                                   >> results
 echo ++ Grade ++    0 = Points earned for correct answers.              >> results
 echo.                                                                   >> results
rem Calculate the grade
gradres
type  gradres.tmp
type  gradres.tmp >> results
erase gradres.tmp
echo. >> results
echo Building the file multiply.ans for electronic submission...
call gradcpy.bat results+multiply.asm multiply.ans
goto     exit

:ok0001
erase testout
erase okay

multdrvr  2 > okay

rem // All tests passed. Grade efficiency.
:end
echo ++ Grade ++   40 = Points earned for correct answers.

echo.                                                      >> results
echo ++ Grade ++   40 = Points earned for correct answers. >> results

rem Grade efficiency
gradeff
echo.
type gradeff.txt
echo.
echo.                                                      >> results
type gradeff.txt                                           >> results

rem Grade documentation
graddoc multiply.asm
echo.
echo.                                                      >> results
graddoc multiply.asm                                       >> results
echo.                                                      >> results

rem Calculate the grade
gradres
type  gradres.tmp
type  gradres.tmp                                          >> results
if exist gradres.tmp erase gradres.tmp
if exist okay        erase okay
if exist testout     erase testout
if exist gradeff.txt erase gradeff.txt

echo Building the file multiply.ans for electronic submission...
echo Building the file multiply.ans for electronic submission... >> results
echo.                                                            >> results
call gradcpy.bat results+multiply.asm multiply.ans
goto exit

:error1
echo.
echo The grading system has detected a problem.
echo Some of the required files are missing.
echo Try to re-copy all the grading files from the course locker.
echo If this fails then contact the instructor.
echo The grading system has detected a problem.                   >> results
echo Some of the required files are missing.                      >> results
echo Try to re-copy all the grading files from the course locker. >> results
echo If this fails then contact the instructor.                   >> results
echo.
goto exit

:error2
echo.
echo The executable file 'multdrvr.exe' does not exist in this directory.
echo Make sure you assembled and linked correctly
echo.
echo The executable file 'multiply.exe' does not exist in this directory. >> results
echo Make sure you assembled and linked correctly                         >> results
goto exit

:error3
echo.
echo The source assembler file 'multiply.asm' does not exist in this directory.
echo This file is needed to continue testing.
echo.
echo The source assembler file 'multiply.asm' does not exist in this directory. >> results
echo This file is needed to continue testing.                                   >> results
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