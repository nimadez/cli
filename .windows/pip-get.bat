@echo off

pause

curl https://bootstrap.pypa.io/get-pip.py -k --ssl-no-revoke -o %tmp%\get-pip.py

%cd%\python %tmp%\get-pip.py

del /s %tmp%\get-pip.py >nul 2>&1

pause
