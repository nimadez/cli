#!/bin/bash
#
# Copy a file/directory using ssh

if [ $# -eq 3 ]; then
    scp -r $1:$2 $3
else
    echo "help: scpr.sh [user@address] [src] [dest]"
fi
