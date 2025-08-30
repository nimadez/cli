#!/bin/bash
#
# Download .deb package without installation
#
# Notice: This may not work for every package (e.g. with dependencies)

if [ $# -eq 1 ]; then
    echo "Downloading [ $1 ]" ...
    if sudo apt install --reinstall --no-install-recommends --download-only "$1" | grep -q 'Download complete'; then
        sudo mv /var/cache/apt/archives/*.deb .
    fi
else
    echo "Usage: apt-download.sh [package]"
fi
