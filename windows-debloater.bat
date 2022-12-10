@echo off
color 03
title Windows Debloater

:: admin check
net session >nul 2>&1
if not %errorLevel% == 0 (
    echo Run as admin && pause && exit
)

:MENU
echo  1. Show All Packages
echo  2. Reinstall Package
echo  3. Uninstall Package
set /p opt="> "
if "%opt%"=="1" goto SHOWALL
if "%opt%"=="2" goto REINSTALL
if "%opt%"=="3" goto UNINSTALL
if "%opt%"=="" goto MENU
goto MENU

:SHOWALL
echo ----------------------------------------------------------------------
echo Cortana Package: Microsoft.549981C3F5F10
echo ----------------------------------------------------------------------
powershell -command "Get-AppxPackage -AllUsers | Select Name, Version, PackageUserInformation, InstallLocation"
goto MENU

:REINSTALL
set /p pkg="Package> "
if "%pkg%"=="" goto MENU
powershell -command "Get-AppXPackage -AllUsers -Name %pkg% | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register \"$($_.InstallLocation)\AppXManifest.xml\" -verbose}"
goto MENU

:UNINSTALL
set /p pkg="Package> "
if "%pkg%"=="" goto MENU
powershell -command "Get-AppxPackage *%pkg%* | Remove-AppxPackage"
goto MENU
