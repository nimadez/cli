@echo off

SET SHA=%1
IF "%SHA%"=="" echo git-revert [commit-hash] && goto END

git reset --hard %SHA%

:END
