@echo off

pause

git update-ref -d HEAD
git add .
git commit -m "Initial commit"
