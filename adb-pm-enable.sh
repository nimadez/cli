#!/bin/bash

if [ $# -eq 1 ]; then
   adb shell pm enable "$1"
else
    echo help: adb-pm-enable.sh [package]
fi
