#!/bin/bash
#
# Revert commits to commit-hash

if [ $# -eq 1 ]; then
    git reset --hard "$1"
else
    echo "Usage: git-revert.sh [hash]"
fi
