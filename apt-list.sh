#!/bin/bash

if [ $# -eq 1 ]; then
    if [ "$1" == "installed" ]; then
        apt-mark showmanual
    elif [ "$1" == "i386" ]; then
        dpkg -l | grep i386
    else
        dpkg-query -W -f='${Section}\t${Package}\n' | grep ^$1
    fi
else
    echo help: apt-list.sh [installed, contrib, non-free, non-free-firmware, i386]
fi
