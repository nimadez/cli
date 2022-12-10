@echo off

:: Optimize and shrink local ".git"
:: remove unreachable objects, compressing file revisions

git gc
