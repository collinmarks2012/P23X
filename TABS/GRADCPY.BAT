@echo off

copy %1 %2  >> gradjunk

:wait
if not exist %2 goto wait

:exit
