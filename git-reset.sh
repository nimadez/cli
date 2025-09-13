#!/bin/bash
#
# Reset a repository

read -p "press enter to reset git ..." p

git update-ref -d HEAD
git add .
git commit -m "Initial commit"
