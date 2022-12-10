@echo off
title XColor

set CHROME="%ProgramFiles%\Google\Chrome\Application\chrome.exe"
set COMMON=--user-data-dir="%appdata%\chrome-xcolor" --window-size=400,200 --window-position=250,50 --no-first-run --disable-gpu --disable-plugins --disable-default-apps --disable-extensions --disable-notifications --disable-file-system --disable-background-networking --disable-sync
set MISC=--autoplay-policy=no-user-gesture-required --force-android-app-mode
set HEADER=--user-agent="Mozilla/5.0 (iPhone; CPU iPhone OS 13_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1 Mobile/15E148 Safari/604.1"

start "" %CHROME% %COMMON% %HEADER% %MISC% --app=file:///D:/Repository/cli/xcolor.html
