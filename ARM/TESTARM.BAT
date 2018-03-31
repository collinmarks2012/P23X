@echo  off
echo.

if %1. == mark. goto tmetest
goto  exit

:tmetest
if exist gradarm.tme goto endtme
echo Grading and testing history log > gradarm.tme
:endtme
gradmark gradarm.tme

:exit
echo.
