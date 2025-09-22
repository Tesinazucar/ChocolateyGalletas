@echo off
:proceso
	set /p f=Dame el nombre completo del fichero a borrar
	echo %f%
	pause
	if exist "%f%" (
		del "%f1%"
		echo borrado
		) else echo "El fichero no existe "
	set /p con=Quieres continuar