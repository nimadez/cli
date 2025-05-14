@echo off

if exist ".git" (
    echo .git already exist && goto END
)

git init --initial-branch=main
git add .
git commit -m "Initial commit"

:END
