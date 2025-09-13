#!/bin/bash
#
# List android packages

DIR=$(dirname $(realpath "$0"))

if [ "$1" = "all" ]; then
    adb shell pm list packages -f | less -X
elif [ "$1" = "enable" ]; then
    adb shell pm list packages -e | less -X
elif [ "$1" = "disable" ]; then
    adb shell pm list packages -d | less -X
else
    echo "Usage: adb-pm-list.sh [all, enable, disable]"
fi
