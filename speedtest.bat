@echo off
color 03
title Speedtest.net

echo Downloading speedtest.py...
curl -s --ssl-no-revoke -o %temp%\speedtest.py https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py

%temp%\speedtest.py --single --secure --no-pre-allocate

pause
