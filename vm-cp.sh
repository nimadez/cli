#!/bin/bash
#
# Copy a file/directory to/from VM using SSH
# (run on a guest machine)

if [ $# -eq 4 ]; then
    host="$1"
    guest="$USER@$(hostname -I | awk '{print $1}')"
    direction="$2"

    case "$direction" in
        "in")  scp -r "$host:$3" "$guest:$4" ;;
        "out") scp -r "$guest:$3" "$host:$4" ;;
        *) echo "Invalid direction (in/out)."; exit 1 ;;
    esac
else
    echo "Usage: vm-cp.sh [user@host] [in|out] [src] [dest]"
fi
