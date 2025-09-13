#!/bin/bash
#
# Commit and squash (redo last commit)

if [ $# -eq 1 ]; then
    if [ -n "$(git status --porcelain | grep -v '^??')" ]; then
        git add .
        git commit -m "$1"

        git reset --soft HEAD~2
        git add .
        git commit -m "$1"
    else
        echo "No changes to commit and squash."
    fi
else
    echo "Usage: git-redo.sh [message]"
fi
