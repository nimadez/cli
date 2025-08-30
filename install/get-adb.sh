#!/bin/bash
#
# Download lastest Android platform tools

read -p "Proxy (host:port): " proxy

echo "Downloading Latest Android Platform Tools ..."

cli aria2 https://dl.google.com/android/repository/platform-tools-latest-linux.zip http://$proxy
