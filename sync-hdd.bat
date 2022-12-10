@echo off
color 03
title Sync HDD

pause

robocopy /mir D:\Android    E:\Android
robocopy /mir D:\Apps       E:\Apps
robocopy /mir D:\Backup     E:\Backup
robocopy /mir D:\Games      E:\Games
robocopy /mir D:\Media      E:\Media
robocopy /mir D:\Repository E:\Repository
robocopy /mir D:\Workshop   E:\Workshop

pause
