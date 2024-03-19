@echo off
title Android SDK Update

:: fodev.org and custom proxy as a fallback

sdkmanager --update && sdkmanager --update --proxy=http --proxy_host=fodev.org --proxy_port=8118 && sdkmanager --update --proxy=http --proxy_host=192.168.1.100 --proxy_port=666
