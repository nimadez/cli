#!/bin/bash

# optimize and shrink local ".git"
# remove unreachable objects, compressing file revisions

git reflog expire --all --expire=now
git gc --prune=now --aggressive
