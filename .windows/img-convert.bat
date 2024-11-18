@echo off

SET IMG=%1
SET EXT=%2

IF "%IMG%"=="" echo img-convert [filepath or *.ext] [jpg,png,ico,...]  && goto END
IF "%EXT%"=="" echo img-convert [filepath or *.ext] [jpg,png,ico,...]  && goto END

FOR %%i IN ("%IMG%") DO (
SET fileDrive=%%~di
SET filePath=%%~pi
SET fileName=%%~ni
SET fileExt=%%~xi
)

echo Source: %IMG%

magick.exe %IMG% -define icon:auto-resize=256,128,64,32 %fileDrive%%filePath%%fileName%.%EXT%

:END
pause
