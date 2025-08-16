#!/bin/bash
#
# List installed packages

if [ "$1" = "all" ]; then
    adb shell pm list packages -f | more
elif [ "$1" = "enable" ]; then
    adb shell pm list packages -e | more
elif [ "$1" = "disable" ]; then
    adb shell pm list packages -d | more
else
    echo "help: adb-pm-list.sh [all, enable, disable]"
fi
