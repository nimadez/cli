#!/bin/bash
#
# List installed packages

if [ "$1" == "all" ]; then
    adb shell pm list packages -f
elif [ "$1" == "enabled" ]; then
    adb shell pm list packages -e
elif [ "$1" == "disabled" ]; then
    adb shell pm list packages -d
else
    echo help: adb-pm-list.sh [all, enabled, disabled]
fi
