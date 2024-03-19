@echo off

SET ARG=%1
IF "%ARG%"=="" echo git-find "string" && goto END

git grep -n %ARG%

:END
