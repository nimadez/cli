#!/bin/bash

if [ $# -eq 2 ]; then
    if [ $1 -eq 0 ]; then
        adb.sh shell pm disable-user --user 0 "$2"
    elif [ $1 -eq 1 ]; then
        adb.sh shell pm enable "$2"
    else
        echo help: adb-pm-set.sh [0/1] [package]
    fi
else
    echo help: adb-pm-set.sh [0/1] [package]
fi
