@echo off
title Twitter

set CHROME="%ProgramFiles%\Google\Chrome\Application\chrome.exe"
set COMMON=--user-data-dir="%appdata%\chrome-twitter" --window-size=1400,900 --window-position=250,50 --no-first-run --disable-plugins --disable-default-apps --disable-extensions --disable-notifications --disable-file-system --disable-background-networking --disable-sync
set MISC=--autoplay-policy=no-user-gesture-required
set HEADER=--user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36"

start "" %CHROME% %COMMON% %HEADER% %MISC% --proxy-server="socks5://127.0.0.1:9050" --app=https://twitter.com
