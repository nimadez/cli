#!/bin/bash
#
# Permanently delete a file with no recovery or more difficult recovery

if [ $# -eq 1 ]; then
    msg="press enter to continue"
    for i in $(seq 1 24); do
        read -p "$msg ..." p
        msg="${msg%?}"
    done

    shred -uvz "$1"
else
    echo "Usage: shredder.sh [file]"
fi
