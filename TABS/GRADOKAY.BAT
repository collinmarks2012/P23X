@echo  off
echo.

rem // verify the user typed the correct command
if %1. == .      goto errcmd

if not exist %1  goto errin

if %2. == .  goto tmetest
if %2. == 1. goto tmetest
if %2. == 2. goto tmetest
if %2. == 3. goto tmetest
if %2. == 4. goto tmetest
if %2. == 5. goto tmetest
if %2. == 6. goto tmetest
if %2. == 7. goto tmetest
if %2. == 8. goto tmetest
if %2. == 9. goto tmetest
goto errcmd

:tmetest
call gradcpy.bat %1+EOF grad.tmp
echo.
echo. To be safe, I added a DOS end_of_file character to %1
echo. and stored the result in grad.tmp which is being used
echo. as the input to the EXPR program.
gradtbok %2 < grad.tmp > okay
echo.
echo 'okay' is the expected output file
goto exit

:errcmd
echo.
echo To run a test type:  gradokay  input_file
echo To run a test type:  gradokay  input_file  n
echo.
goto   exit

:errin
echo.
echo The input file specified: %1 does not exist.
echo.
goto   exit

:exit
if exist gradjunk erase gradjunk
echo.
