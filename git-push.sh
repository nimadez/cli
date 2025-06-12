#!/bin/bash
#
# Force push to remote (main/master)

read -p "press enter to push changes ..." p

if [ $# -eq 1 ]; then
    git push -f -u origin "$1" # master
else
    git push -f -u origin main
fi
