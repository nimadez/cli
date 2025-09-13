#!/bin/bash
#
# Commit changes

if [ $# -eq 1 ]; then
    git add .
    git commit -m "$1"
else
    echo "Usage: git-commit.sh [message]"
fi
