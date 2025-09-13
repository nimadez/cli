#!/bin/bash
#
# Watch changes to a file or command

if [ $# -gt 1 ]; then
    watch -t -c -n "$@"
else
    echo "Usage: watchdog.sh [seconds] [command]"
fi
