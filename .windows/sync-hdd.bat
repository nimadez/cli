@echo off
color 03
title Sync HDD

pause

robocopy /mir D:\Apps       F:\Apps
robocopy /mir D:\Backup     F:\Backup
robocopy /mir D:\Media      F:\Media
robocopy /mir D:\ML         F:\ML
robocopy /mir D:\Repo       F:\Repo
robocopy /mir D:\SDK        F:\SDK

pause
