@echo off
cls
set /p n1=Dame un numero 
set /p n2=Dame otro numero 

if %n1% lss %n2% (
	echo %n1% es el menor
) else echo %n2% es el menor

pause > nul