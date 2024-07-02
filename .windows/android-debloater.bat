@echo off
color 03
title Android Debloater

:MENU
echo  1. Show All Packages
echo  2. Show Disabled Packages
echo  3. Enable Package
echo  4. Disable Package
set /p opt="> "
if "%opt%"=="1" goto SHOW_ALL
if "%opt%"=="2" goto SHOW_DISABLED
if "%opt%"=="3" goto PKG_ENABLE
if "%opt%"=="4" goto PKG_DISABLE
if "%opt%"=="" goto MENU
goto MENU

:SHOW_ALL
cls
echo :: Package List ::
adb shell pm list packages -f
goto MENU

:SHOW_DISABLED
cls
echo :: Disabled Packages ::
adb shell pm list packages -d
goto MENU

:PKG_ENABLE
set /p pkg="Package> "
if "%pkg%"=="" goto MENU
adb shell pm enable %pkg%
goto MENU

:PKG_DISABLE
set /p pkg="Package> "
if "%pkg%"=="" goto MENU
adb shell pm disable-user --user 0 %pkg%
goto MENU
