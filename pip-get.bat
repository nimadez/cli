@echo off
title PIP Get

pause

rd /S /Q D:\Apps\Python\Lib >nul 2>&1
rd /S /Q D:\Apps\Python\Scripts >nul 2>&1

curl https://bootstrap.pypa.io/get-pip.py --ssl-no-revoke -o %tmp%\get-pip.py

python %tmp%\get-pip.py

del /s %tmp%\get-pip.py >nul 2>&1

pip install requests

pause
