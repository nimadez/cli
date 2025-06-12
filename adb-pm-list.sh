#!/bin/bash
#
# List installed packages

if [ $# -eq 1 ]; then
    if [ $1 == "disabled" ]; then
        adb shell pm list packages -d
    elif [ $1 == "enabled" ]; then
        adb shell pm list packages -e
    else
        adb shell pm list packages -f
    fi
else
    echo help: adb-pm-list.sh [all/enabled/disabled]
fi
