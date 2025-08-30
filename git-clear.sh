#!/bin/bash
#
# Optimize and shrink local .git
# - remove unreachable objects
# - compressing file revisions
#
# Notice: This method is not suitable for heavy gits.

git reflog expire --all --expire=now
git gc --prune=now --aggressive
