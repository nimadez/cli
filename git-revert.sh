#!/bin/bash

if [ $# -eq 1 ]; then
    git reset --hard "$1"
else
    echo help: git-revert.sh [commit-hash]
fi
