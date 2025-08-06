#!/bin/bash
#
# Download lastest Chromium (no codecs) - with a middle-finger!

URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2FLAST_CHANGE?alt=media"
VER=$(curl -s -S $URL)
LNK=https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F$VER%2Fchrome-linux.zip?alt=media

echo Downloading Chromium [ $VER ] ...

aria2 $LNK http://localhost:8118
