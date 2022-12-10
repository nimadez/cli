@echo off

SET MSG=%1
IF ""%MSG%""=="""" echo git-amend ["new message"] && goto END

git commit --amend -m %MSG%

:END
