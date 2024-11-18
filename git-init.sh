#!/bin/bash
#
# Initialize a repository

read -p "press enter to initialize git ..." p

if [ ! -d .git ]; then
    git init --initial-branch=main
    git add .
    git commit -m "Initial commit"
fi
