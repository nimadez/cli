#!/bin/bash
#
# Download lastest Android platform tools

read -p "Proxy (host:port): " proxy

echo "Downloading Latest Android Platform Tools ..."

aria2c --all-proxy=http://$proxy https://dl.google.com/android/repository/platform-tools-latest-linux.zip
