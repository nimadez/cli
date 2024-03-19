@echo off

SET ARG=%1
IF "%ARG%"=="" echo git-amend "new message" && goto END

git commit --amend -m %ARG%

:END
