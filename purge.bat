@echo off

del "%tmp%\*.*" /s /q /f
FOR /d %%p IN ("%tmp%\*.*") DO rmdir "%%p" /s /q

del "D:\Apps\WinRAR\Temp\*.*" /s /q /f
FOR /d %%p IN ("D:\Apps\WinRAR\Temp\*.*") DO rmdir "%%p" /s /q

Taskkill /F /IM tor.exe
Taskkill /F /IM obfs4proxy.exe
Taskkill /F /IM snowflake-client.exe
rd /S /Q %appdata%\tor

Taskkill /F /IM adb.exe

ipconfig /flushdns
