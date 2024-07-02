#!/bin/bash

# pass the array as arguments, example:
# adb-debloat.sh com.facebook.system \
#                com.facebook.katana \
#                com.facebook.catjuice

if [ $# -gt 0 ]; then
    for arg in "${@}"; do
        adb-pm-set.sh 0 "$arg"
    done
else
    echo help: adb-debloat.sh [pkg1 pkg2 pkg3 ...]
fi
