#!/bin/bash
#
# Debloat android device with a given list
#
# pass the array as arguments, example:
# adb-debloat.sh com.facebook.system \
#                com.facebook.katana \
#                com.facebook.catjuice

if [ $# -gt 0 ]; then
    for arg in "${@}"; do
        adb shell pm disable-user --user 0 "$arg"
    done
else
    echo help: adb-debloat [pkg1 pkg2 pkg3 ...]
fi
