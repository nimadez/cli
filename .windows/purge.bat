@echo off

del "%tmp%\*.*" /s /q /f
FOR /d %%p IN ("%tmp%\*.*") DO rmdir "%%p" /s /q

del "D:\Apps\WinRAR\Temp\*.*" /s /q /f
FOR /d %%p IN ("D:\Apps\WinRAR\Temp\*.*") DO rmdir "%%p" /s /q

ipconfig /flushdns
