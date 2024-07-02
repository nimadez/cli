@echo off

adb devices

set /p IP="IP Address: "
if "%IP%"=="" goto END

adb tcpip 5555
adb connect %IP%:5555
pause

:END
