#!/bin/bash
#
# Squash multiple commits

if [ $# -eq 2 ]; then
    git reset --soft HEAD~$1
    git add .
    git commit -m "$2"
else
    echo help: git-squash.sh [num] [message]
fi
