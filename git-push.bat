@echo off

pause

set ARG=%1
IF "%ARG%"=="" git push -f -u origin main && goto END

git push -f -u origin %ARG%

:END
