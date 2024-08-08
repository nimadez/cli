#!/bin/bash

if [ $# -eq 1 ]; then
    if [ $1 == "disable" ]; then
        adb shell pm list packages -d
    elif [ $1 == "enable" ]; then
        adb shell pm list packages -e
    else
        adb shell pm list packages -f
    fi
else
    echo help: adb-pm-list.sh [enable, disable, all]
fi
