#!/bin/bash
#
# Download lastest Chromium

URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2FLAST_CHANGE?alt=media"
VER=$(curl -s -S -x http://localhost:8118 $URL)
LNK=https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F$VER%2Fchrome-linux.zip?alt=media

echo "Downloading Chromium [ $VER ] ..."

aria2 $LNK http://localhost:8118
