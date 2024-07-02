@echo off

SET ARG=%1
IF "%ARG%"=="" echo git-commit "message" && goto END

git add .
git commit -m %ARG%

:END
