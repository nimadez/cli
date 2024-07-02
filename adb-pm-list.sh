#!/bin/bash

if [ $# -eq 1 ]; then
    if [ $1 -eq 0 ]; then
        adb.sh shell pm list packages -d
    elif [ $1 -eq 1 ]; then
        adb.sh shell pm list packages -e
    else
        adb.sh shell pm list packages -f
    fi
else
    echo help: adb-pm-list.sh [0/1/any]
fi
