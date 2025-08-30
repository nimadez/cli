#!/bin/bash
#
# Kills a process by PID, or kills all processes by name
# (recognizes numeric or string input to define a command)

if [ $# -eq 1 ]; then
    if [[ "$1" =~ ^-?[0-9]+$ ]]; then
        kill -9 "$1"
    else
        killall "$1"
    fi
else
    echo "Usage: kills.sh [pid/name]"
fi
