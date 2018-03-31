@echo off
if %1. == .     goto error1
if %2. == .     goto error1
if not exist %1 goto error2
if     exist %2 goto error3

copy  %1+e:\samples\EOF %2
goto exit

:error1
echo The format is ... addeof source destination
goto exit

:error2
echo The source file %1 does not exist
goto exit

:error3
echo The destination file %2 already exists
echo Erase the destination file %2 and try again
goto exit

:exit
