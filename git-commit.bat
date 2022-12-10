@echo off

SET MSG=%1
IF ""%MSG%""=="""" echo git-commit ["message"] && goto END

git add .
git commit -m %MSG%

:END
