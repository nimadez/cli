@echo off
title Android SDK Package Installer

start "" sdkmanager --list --proxy=http --proxy_host=fodev.org --proxy_port=8118

set /p pkg="Package Name> "
sdkmanager "%pkg%" --proxy=http --proxy_host=fodev.org --proxy_port=8118
