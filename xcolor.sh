#!/bin/bash

src=file:///media/$USER/local/workspace/cli/xcolor.html
chrome.sh --force-android-app-mode --window-size=350,150 --window-position=250,50 --no-first-run --disable-plugins --disable-default-apps --disable-extensions --disable-notifications --disable-file-system --disable-background-networking --disable-sync --app=$src &
