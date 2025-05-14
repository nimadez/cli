#!/bin/bash
#
# Watch changes to a file or bash commands

if [ $# -eq 2 ]; then
    watch -t -c -n "$1" "$2"
else
    echo help: watchdog.sh [seconds] [path/command]
fi
