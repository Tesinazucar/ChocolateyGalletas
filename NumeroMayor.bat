@echo off
cls
rem set /p n1=Dame un numero 
rem set /p n2=Dame otro numero 

if %1 gtr %2 (
	echo %1 es el mayor
) else echo %2 es el mayor

pause > nul