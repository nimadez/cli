#!/bin/bash
#
# Get list of ports used by processes
# (can also filter specific process by name)

if [ $# -eq 1 ]; then
    lsof -i -P -n | grep "$1"
else
    lsof -i -P -n
fi
