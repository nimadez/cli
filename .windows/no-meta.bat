@echo off
title Remove file metadata

set ARG=%1
if "%ARG%"=="" echo no-meta.bat [path-to-file] && goto END

exiftool -All= %ARG%
echo done!
goto OUT

:END
pause

:OUT
