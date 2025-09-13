#!/bin/bash
#
# Amend last commit

if [ $# -eq 1 ]; then
    git commit --amend -m "$1"
else
    echo "Usage: git-amend.sh [message]"
fi
