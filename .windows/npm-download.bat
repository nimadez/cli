@echo off
title Download NPM package to current directory

SET PKG=%1
IF ""%PKG%""=="""" echo npn [package] && goto END

mkdir node_modules
npm install --prefix node_modules %PKG%

:END
