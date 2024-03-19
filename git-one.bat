@echo off

pause

SET ARG=%1
IF ""%ARG%""=="""" echo git-one "message" && goto END

git add .
for /f "tokens=1 delims=" %%a in ('git commit -m %%ARG%%') do set OK=%%a
if "%OK%"=="nothing to commit, working tree clean" echo Nothing to commit && goto END

:: squash
git reset --soft HEAD~2
git commit -m %ARG%

echo [ PUSH ]
set ROOT=%2
if not "%ROOT%"=="" git push -f -u origin %ROOT% && goto END
git push -f -u origin main

:END
git gc >nul 2>&1
