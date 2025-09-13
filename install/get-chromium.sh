#!/bin/bash
#
# Download lastest Chromium

read -p "Proxy (host:port): " proxy

URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2FLAST_CHANGE?alt=media"
VER=$(curl -s -S -x http://$proxy $URL)
LNK=https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F$VER%2Fchrome-linux.zip?alt=media

echo "Downloading Chromium [ $VER ] ..."

aria2c --all-proxy=http://$proxy $LNK
