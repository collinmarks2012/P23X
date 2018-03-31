@echo off

copy %1 %2

:wait
if not exist %2 goto wait

:exit
