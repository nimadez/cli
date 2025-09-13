#!/bin/bash
#
# Initialize a repository

if [ ! -d .git ]; then
    read -p "press enter to initialize git ..." p
    git init --initial-branch=main
    git add .
    git commit -m "Initial commit"
else
    echo "This is a git repository!"
fi
