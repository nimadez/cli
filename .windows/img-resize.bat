@echo off

SET IMG=%1
SET SIZE=%2

IF "%IMG%"=="" echo img-resize [filepath or *.ext] [512x512/50%%] && goto END
IF "%SIZE%"=="" echo img-resize [filepath or *.ext] [512x512/50%%] && goto END

FOR %%i IN ("%IMG%") DO (
SET fileDrive=%%~di
SET filePath=%%~pi
SET fileName=%%~ni
SET fileExt=%%~xi
)

FOR /f "delims=" %%a in ('magick identify -format "%%[w]x%%[h]" %IMG%') do set SIZE_ORG=%%a

echo Source: %IMG%
echo Size: %SIZE_ORG%

magick.exe %IMG% -resize %SIZE%! %fileDrive%%filePath%%fileName%_%SIZE%%fileExt%

:END
pause
