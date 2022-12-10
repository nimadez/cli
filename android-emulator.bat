@echo off

echo Devices:
echo --------------------
emulator -list-avds
echo --------------------
set /p device="Device Name> "
emulator -avd %device%
