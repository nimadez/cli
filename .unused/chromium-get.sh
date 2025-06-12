#!/bin/bash
#
# notice: dev-build, no codecs

URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2FLAST_CHANGE?alt=media"
VER=$(curl --proxy http://localhost:8118 -s -S $URL)

echo version: $VER
echo download link:
echo https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F$VER%2Fchrome-linux.zip?alt=media
