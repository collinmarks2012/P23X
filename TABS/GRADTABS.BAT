@echo  off
echo.

if exist tabs.ans      erase tabs.ans
if exist grad*.in      erase grad*.in
if exist gradres.tmp   erase gradres.tmp
if exist gradtemp      erase gradtemp
if exist okay          erase okay
if exist testout       erase testout

if exist results       erase results
if exist results       goto  locked

if not exist tabs.asm     goto error3
if not exist tabs.exe     goto error2
if not exist gradcomp.exe goto error1
if not exist gradcpy.bat  goto error1
if not exist graddat1.exe goto error1
if not exist graddoc.exe  goto error1
if not exist gradtbok.exe goto error1
if not exist gradtabs.mod goto error1
if not exist gradgtl.exe  goto error1
if not exist gradlog.exe  goto error1
if not exist gradlogt.exe goto error1
if not exist gradmtab.exe goto error1
if not exist gradres.exe  goto error1

rem // init grading count
if exist gradtabs.cnt goto tmetest
call gradcpy gradtabs.mod gradtabs.cnt
:tmetest

rem // init history log
if exist gradtabs.tme goto endtme
echo Grading and testing history log > gradtabs.tme
:endtme
if %1. == s. goto run
gradgtl gradtabs.tme
if errorlevel 4 goto exit

:run
rem // update count and log
gradlog gradtabs.cnt gradtabs.tme p17 1
if errorlevel 4 goto locked

echo TABS Grading System Version 4.0
echo TABS Grading System Version 4.0 >> results

type  gradid.p17
type  gradid.p17    >> results
type  gradtabs.tme  >> results


:t01
graddat1
if       errorlevel 1 goto exit
 echo    Running test 01   ...  tabs   gradin.1                      >> results
 echo    Running test 01   ...  tabs   gradin.1
gradtbok < gradin.1 > okay
    tabs < gradin.1 > testout
gradcomp
if       not errorlevel 1 goto fin01
 echo.
 echo    Error encountered in test 01
 echo    gradin.1    is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo ++ Grade ++    0 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 01                                   >> results
 echo    gradin.1    is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++    0 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradesum
:fin01
erase gradin.1
erase testout
erase okay


:t01A
graddat1
if       errorlevel 1 goto exit
 echo    Running test 01A  ...  tabs 6 gradin.1                      >> results
 echo    Running test 01A  ...  tabs 6 gradin.1
gradtbok 6 < gradin.1 > okay
    tabs 6 < gradin.1 > testout
gradcomp
if       not errorlevel 1 goto fin01A
 echo.
 echo    Error encountered in test 01A
 echo    gradin.1    is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo ++ Grade ++    0 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 01A                                  >> results
 echo    gradin.1    is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++    0 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradesum
:fin01A
erase gradin.1
erase testout
erase okay


:t01B
graddat1
if       errorlevel 1 goto exit
 echo    Running test 01B  ...  tabs 1 gradin.1                      >> results
 echo    Running test 01B  ...  tabs 1 gradin.1
gradtbok 1 < gradin.1 > okay
    tabs 1 < gradin.1 > testout
gradcomp
if       not errorlevel 1 goto fin01B
 echo.
 echo    Error encountered in test 01B
 echo    gradin.1    is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo ++ Grade ++    0 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 01B                                  >> results
 echo    gradin.1    is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++    0 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradesum
:fin01B
erase gradin.1
erase testout
erase okay



:t02
graddat2
if       errorlevel 1 goto exit
 echo    Running test 02   ...  tabs   gradin.2                      >> results
 echo    Running test 02   ...  tabs   gradin.2
gradtbok < gradin.2 > okay
    tabs < gradin.2 > testout
gradcomp
if       not errorlevel 1 goto fin02
 echo.
 echo    Error encountered in test 02
 echo    gradin.2    is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo ++ Grade ++    0 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 02                                   >> results
 echo    gradin.2    is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++    0 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradesum
:fin02
erase gradin.2
erase testout
erase okay



:t02A
graddat2
if       errorlevel 1 goto exit
 echo    Running test 02A  ...  tabs 5 gradin.2                      >> results
 echo    Running test 02A  ...  tabs 5 gradin.2
gradtbok 5 < gradin.2 > okay
    tabs 5 < gradin.2 > testout
gradcomp
if       not errorlevel 1 goto fin02A
 echo.
 echo    Error encountered in test 02A
 echo    gradin.2    is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo ++ Grade ++    0 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 02A                                  >> results
 echo    gradin.2    is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++    0 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradesum
:fin02A
erase gradin.2
erase testout
erase okay


:t02B
graddat2
if       errorlevel 1 goto exit
 echo    Running test 02B  ...  tabs 2 gradin.2                      >> results
 echo    Running test 02B  ...  tabs 2 gradin.2
gradtbok 2 < gradin.2 > okay
    tabs 2 < gradin.2 > testout
gradcomp
if       not errorlevel 1 goto fin02B
 echo.
 echo    Error encountered in test 02B
 echo    gradin.2    is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo ++ Grade ++    0 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 02B                                  >> results
 echo    gradin.2    is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++    0 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradesum
:fin02B
erase gradin.2
erase testout
erase okay



:t03
graddat3
if       errorlevel 1 goto exit
 echo    Running test 03   ...  tabs   gradin.3                      >> results
 echo    Running test 03   ...  tabs   gradin.3
gradtbok < gradin.3 > okay
    tabs < gradin.3 > testout
gradcomp
if       not errorlevel 1 goto fin03
 echo.
 echo    Error encountered in test 03
 echo    gradin.3    is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo ++ Grade ++    0 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 03                                   >> results
 echo    gradin.3    is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++    0 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradesum
:fin03
erase gradin.3
erase testout
erase okay


:t03A
graddat3
if       errorlevel 1 goto exit
 echo    Running test 03A  ...  tabs 7 gradin.3                      >> results
 echo    Running test 03A  ...  tabs 7 gradin.3
gradtbok 7 < gradin.3 > okay
    tabs 7 < gradin.3 > testout
gradcomp
if       not errorlevel 1 goto fin03A
 echo.
 echo    Error encountered in test 03A
 echo    gradin.3    is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo ++ Grade ++    0 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 03A                                  >> results
 echo    gradin.3    is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++    0 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradesum
:fin03A
erase gradin.3
erase testout
erase okay


:t03B
graddat3
if       errorlevel 1 goto exit
 echo    Running test 03B  ...  tabs 3 gradin.3                      >> results
 echo    Running test 03B  ...  tabs 3 gradin.3
gradtbok 3 < gradin.3 > okay
    tabs 3 < gradin.3 > testout
gradcomp
if       not errorlevel 1 goto fin03B
 echo.
 echo    Error encountered in test 03B
 echo    gradin.3    is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo ++ Grade ++    0 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 03B                                  >> results
 echo    gradin.3    is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++    0 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradesum
:fin03B
erase gradin.3
erase testout
erase okay


echo    *** Passed all functional tests
echo    *** Passed all functional tests  >> results

rem // All tests passed. Grade efficiency.
:end
Echo ++ Grade ++   60 = Points earned for correct answers.
Echo ++ Grade ++   60 = Points earned for correct answers. >> results
echo.
echo. >> results

rem Grade efficiency
gradmtab tabs.asm >> results
gradmtab tabs.asm
echo.
echo. >> results



:gradedoc
rem Grade documentation
graddoc tabs.asm >> results
graddoc tabs.asm
echo.
echo. >> results



:gradesum
rem Calculate the grade
gradres
type  gradres.tmp
type  gradres.tmp >> results
erase gradres.tmp

echo Building the file tabs.ans for electronic submission...
echo Building the file tabs.ans for electronic submission... >> results
echo. >> results
call gradcpy.bat results+tabs.asm tabs.ans
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
echo The executable file 'tabs.exe' does not exist in this directory.
echo.
echo The executable file 'tabs.exe' does not exist in this directory. >> results
goto exit

:error3
echo.
echo The source assembler file 'tabs.asm' does not exist in this directory.
echo This file is needed to continue testing.
echo.
echo The source assembler file 'tabs.asm' does not exist in this directory. >> results
echo This file is needed to continue testing.                                   >> results
goto exit

:locked
echo.
echo The grading system can not access its files.
echo Shutdown the system and reboot.
echo.
goto exit

:exit
if exist gradjunk erase gradjunk
echo ************************************************************************
echo ***** In case they scrolled by too quickly ... all messages        *****
echo ***** written to the display were also written to the RESULTS file *****
echo ************************************************************************
