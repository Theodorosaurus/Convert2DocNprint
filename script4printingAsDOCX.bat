@echo off

SET A=%SYSTEMDRIVE%

"%A%\Program Files\ExampleInternetBrowser\Application\examplebrowser.exe" --profile-directory=Default --app=https://www.example.com/pdfs4download --kiosk-printing --start-maximized

timeout /t 2 /nobreak >nul

:y

SET W="%A%\users\%USERNAME%\Downloads\*.pdf"

IF EXIST %W% (
	"%A%\users\%USERNAME%\Documents\examplepdf2wordconverter.exe" -input "%A%\Users\%USERNAME%\Downloads\*.pdf" -output "%A%:\Users\%USERNAME%\Downloads\example.docx"
	del /Q /F "%A%\Users\%USERNAME%\Downloads\*.pdf"
	"%A%\Program Files\libreoffice\program\swriter.exe" -pt "EXAMPLE PRINTER" "%A%\Users\%USERNAME%\Downloads\example.docx"
	del /Q /F "%A%\Users\%USERNAME%\Downloads\example.docx"
	timeout /t 5 /nobreak >nul
	goto x
)

:x
for /f "tokens=2" %%B in ('tasklist /NH /FI "imagename eq examplebrowser.exe"') do (echo %%B > "%A%\users\%username%\Documents\browserPID.txt")
set /P var=<"%A%\users\%username%\Documents\browserPID.txt"
tasklist /FI "PID EQ %var%"

IF %errorlevel%==0 (
	goto y
)
ELSE (
	del /Q /F "%A%\users\%username%\Documents\browserPID.txt"
	goto :EOF
)

:EOF
