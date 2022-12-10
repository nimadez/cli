@echo off
title Twitter

set CHROME="%ProgramFiles%\Google\Chrome\Application\chrome.exe"
set COMMON=--user-data-dir="%appdata%\chrome-twitter" --window-size=1400,900 --window-position=250,50 --no-first-run --disable-gpu --disable-plugins --disable-default-apps --disable-extensions --disable-notifications --disable-file-system --disable-background-networking --disable-sync
set MISC=--autoplay-policy=no-user-gesture-required --force-android-app-mode
set HEADER=--user-agent="Mozilla/5.0 (iPhone; CPU iPhone OS 13_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1 Mobile/15E148 Safari/604.1"

start "" %CHROME% %COMMON% %HEADER% %MISC% --proxy-server="socks5://127.0.0.1:9050" --app=https://mobile.twitter.com/
