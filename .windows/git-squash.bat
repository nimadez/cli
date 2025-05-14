@echo off

SET NUM=%1
SET MSG=%2
IF "%NUM%"=="" echo git-squash [commits-num] "message" && goto END
IF ""%MSG%""=="""" echo git-squash [commits-num] "message" && goto END

git reset --soft HEAD~%NUM%
git add .
git commit -m %MSG%

:END
