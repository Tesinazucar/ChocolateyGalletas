@echo off
set /p num=Dame un numero 
for /l %%i in (1 2 %%num) do (
	echo %%i
	timeout 1 > nul
	)

pause > nul