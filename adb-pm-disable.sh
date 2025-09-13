#!/bin/bash
#
# Disable android apps with a given list
#
# adb-pm-disable.sh com.facebook.system \
#                   com.facebook.katana \
#                   com.facebook.catjuice

DIR=$(dirname $(realpath "$0"))

if [ $# -gt 0 ]; then
    for arg in "${@}"; do
        adb shell pm disable-user --user 0 "$arg"
    done
else
    echo "Usage: adb-pm-disable [pkg1 pkg2 pkg3 ...]"
fi
