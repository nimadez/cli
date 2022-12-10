@echo off

SET STR=%1
IF ""%STR%""=="""" echo git-find ["string"] && goto END

git grep -n %STR%

:END
