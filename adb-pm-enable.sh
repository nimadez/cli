#!/bin/bash
#
# Re-enable android app by package id

if [ $# -eq 1 ]; then
   adb shell pm enable "$1"
else
    echo help: adb-pm-enable.sh [package]
fi
