@echo off
color 03
title Aria2 Downloader

(
echo dir=%USERPROFILE%\Downloads
echo log-level=notice
echo check-certificate=false
echo disable-ipv6=true
echo file-allocation=none
echo proxy-method=get
echo connect-timeout=120
echo http-no-cache=true
echo disk-cache=0
echo #
echo continue=true
echo allow-overwrite=false
echo max-overall-download-limit=0
echo max-overall-upload-limit=0
echo max-concurrent-downloads=1
echo min-split-size=20M
echo max-connection-per-server=16
echo split=16
echo #
echo seed-time=0
echo enable-peer-exchange=true
echo bt-save-metadata=true
echo bt-hash-check-seed=true
echo bt-remove-unselected-file=true
echo #
echo enable-rpc=false
echo rpc-listen-port=6800
echo rpc-allow-origin-all=true
echo rpc-listen-all=true
echo rpc-save-upload-metadata=true
echo rpc-secure=false
)> "%tmp%\aria2.conf"

:: fast direct download using: 'aria2 <url>'
set ARG=%1
if not "%ARG%"=="" aria2c --conf-path=%tmp%\aria2.conf %ARG% && goto END

:MENU
echo [1] Direct
echo [2] Proxified
echo [3] Torrent File
echo [4] Queue File
echo [5] Start RPC Server
set /p ops="> "
if "%ops%"=="1" goto DIRECT
if "%ops%"=="2" goto PROXY
if "%ops%"=="3" goto TORRENT
if "%ops%"=="4" goto QUEUE
if "%ops%"=="5" goto RPC
goto MENU

:DIRECT
set /p link="Link/Magnet> "
if "%link%"=="" goto MENU
aria2c --conf-path=%tmp%\aria2.conf %link%
goto MENU

:PROXY
set /p link="Link/Magnet> "
if "%link%"=="" goto MENU
set /p proxy="Proxy IP:PORT> "
if "%link%"=="" %proxy%="192.168.1.100:666"
aria2c --conf-path=%tmp%\aria2.conf --all-proxy=%proxy% %link%
goto MENU

:TORRENT
set /p torrent="Torrent File Path> "
IF "%torrent%"=="" goto MENU
aria2c --conf-path=%tmp%\aria2.conf --torrent-file=%torrent%
goto MENU

:QUEUE
set /p queue="Queue File Path> "
IF "%queue%"=="" goto MENU
aria2c --conf-path=%tmp%\aria2.conf --input-file=%queue%
goto MENU

:RPC
aria2c --conf-path=%tmp%\aria2.conf --enable-rpc=true
goto MENU

:END
pause
