@echo off
title Audio Player
color 03

set COMMON=-hide_banner -autoexit -loop 0 -reconnect 1 -reconnect_streamed 1 -reconnect_on_network_error 1 -multiple_requests 1 -reconnect_delay_max 4294 -volume 100

set ARG=%1
if "%ARG%"=="" echo play-audio [url] && goto END

set /p p="Use Proxy (y/n)? "
set PROXY=-hide_banner
if "%p%"=="y" set PROXY=-http_proxy http://127.0.0.1:8118

echo ----------------------------------------------------------------------------------
echo  Press CTRL+C twice to stop audio playback
echo ----------------------------------------------------------------------------------
ffplay -nodisp %COMMON% %PROXY% %ARG%

:END
Pause
