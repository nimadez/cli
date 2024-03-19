@echo off
title Stream Video
color 03

set COMMON=-hide_banner -autoexit -loop 0 -reconnect 1 -reconnect_streamed 1 -reconnect_on_network_error 1 -multiple_requests 1 -reconnect_delay_max 4294 -volume 100

set ARG=%1
if "%ARG%"=="" echo stream-video [url] && goto END

set /p p="Use Proxy (y/n)? "
set PROXY=-hide_banner
if "%p%"=="y" set PROXY=-http_proxy http://192.168.1.100:666

echo ----------------------------------------------------------------------------------
echo    - C           Cycle program
echo    - F           Toggle fullscreen
echo    - LEFT/RIGHT  Seek
echo    - SPACE       Pause
echo    - ESC         Quit
echo ----------------------------------------------------------------------------------
ffplay -x 1280 -y 720 -sn %COMMON% %PROXY% %ARG%

:END
Pause
