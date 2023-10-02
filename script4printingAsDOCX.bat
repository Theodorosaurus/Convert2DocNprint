@echo off

cd C:\Program Files\Google\Chrome\Application\

start chrome_proxy.exe --profile-directory=Default --app=https://web.eu.restaurant-partners.com/orders --kiosk-printing --start-maximized --enable-safebrowsing-enhanced-protection

timeout /t 2 /nobreak >nul

:y

SET W="c:\users\%USERNAME%\Desktop\efood\*.pdf"

IF EXIST %W% (
	cd C:\Users\%USERNAME%\Desktop\efood\pdf2word\
	pdf2word.exe -matchLines on -in c:\Users\%USERNAME%\Desktop\efood\*.pdf -out c:\Users\%USERNAME%\Desktop\efood\printorder.docx
	del /Q /F c:\Users\%USERNAME%\Desktop\efood\*.pdf
	cd c:\program^ files\libreoffice\program\
	swriter.exe -pt "HP DeskJet 2300 series" c:\Users\%USERNAME%\Desktop\efood\printorder.docx
	del /Q /F c:\Users\%USERNAME%\Desktop\efood\printorder.docx
	timeout /t 5 /nobreak >nul
	goto x
)

:x
for /f "tokens=2" %%A in ('tasklist /NH /FI "imagename eq chrome.exe"') do (echo %%A > "c:\users\%username%\desktop\efood\chromePID.txt")
set /P var=<"c:\users\%username%\desktop\efood\chromePID.txt"
tasklist /FI "PID EQ %var%"

IF %errorlevel%==0 (
	goto y
)
ELSE (
	del c:\users\%username%\desktop\efood\chromePID.txt
	goto :EOF
)

:EOF