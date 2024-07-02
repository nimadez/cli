#!/bin/bash

if [ $# -eq 1 ]; then
    if [[ `git status --porcelain --untracked-files=no` ]]; then
        git add .
        git commit -m "$1"

        git reset --soft HEAD~2
        git add .
        git commit -m "$1"
    else
        echo no changes to commit and squash.
    fi
    
else
    echo help: git-last.sh [message]
fi
