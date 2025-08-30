#!/bin/bash
#
# Enable android apps with a given list
#
# adb-pm-enable.sh com.facebook.system \
#                  com.facebook.katana \
#                  com.facebook.catjuice

if [ $# -gt 0 ]; then
    for arg in "${@}"; do
        adb shell pm enable "$arg"
    done
else
    echo "Usage: adb-pm-enable.sh [pkg1 pkg2 pkg3 ...]"
fi
