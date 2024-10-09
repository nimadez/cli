@echo off
title Android SDK Package Installer

start "" sdkmanager --list

set /p pkg="Package Name> "
sdkmanager "%pkg%"
