@echo off

pause

SET MSG=%1
IF ""%MSG%""=="""" echo git-me ["message"] && goto END

git add .
for /f "tokens=1 delims=" %%a in ('git commit -m %%MSG%%') do set OK=%%a
if "%OK%"=="nothing to commit, working tree clean" echo Nothing to commit && goto END

:: squash
git reset --soft HEAD~2
git commit -m %MSG%

echo [ PUSH ]
git push -f -u origin main

:: clear
git gc >nul 2>&1

:END
