#!/bin/bash
#
# List software

if [ $# -eq 1 ]; then
    if [ "$1" == "all" ]; then
        apt list
    elif [ "$1" == "installed" ]; then
        apt list --installed
    elif [ "$1" == "backports" ]; then
        dpkg-query -W | grep '~bpo'
    elif [ "$1" == "contrib" ]; then
        dpkg-query -W -f='${Section}\t${Package}\n' | grep ^contrib
    elif [ "$1" == "non-free" ]; then
        dpkg-query -W -f='${Section}\t${Package}\n' | grep ^non-free
    elif [ "$1" == "non-free-firmware" ]; then
        dpkg-query -W -f='${Section}\t${Package}\n' | grep ^non-free-firmware
    elif [ "$1" == "i386" ]; then
        dpkg -l | grep i386
    else
        echo help: apt-list.sh [all/installed/backports/contrib/non-free/non-free-firmware/i386]
    fi
else
    echo help: apt-list.sh [all/installed/backports/contrib/non-free/non-free-firmware/i386]
fi
