#!/bin/bash
#
# Amend last commit

if [ $# -eq 1 ]; then
    git commit --amend -m "$1"
else
    echo help: git-amend.sh [message]
fi
