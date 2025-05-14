@echo off
color 0A
title DNS Switch

:: admin check
net session >nul 2>&1
if not %errorLevel% == 0 (
    echo Run as admin && pause && exit
)

:LOOP
ipconfig /flushdns
cls
for /f "tokens=2 delims=: " %%a in ('echo quit^|nslookup^|find "Address:"') do set DNS=%%a
echo =====================================================
echo  :: Primary DNS is [ %DNS% ]
echo =====================================================
echo  0. Fastest ....... 1.1.1.1 / 1.0.0.1
echo  1. Mixed ......... 8.8.8.8 / 1.1.1.1
echo =====================================================
echo  2. Google ........ 8.8.8.8 / 8.8.4.4
echo  3. Cloudflare .... 1.1.1.1 / 1.0.0.1
echo  4. OpenDNS ....... 208.67.222.222 / 208.67.220.220
echo  5. UltraDNS ...... 156.154.70.1 / 156.154.71.1
echo =====================================================
echo  B. Run Benchmark
echo =====================================================
set /p opt="> "
setlocal EnableDelayedExpansion
if "%opt%"=="0" set DNSA=1.1.1.1 && set DNSB=1.0.0.1 && goto SETDNS
if "%opt%"=="1" set DNSA=8.8.8.8 && set DNSB=1.1.1.1 && goto SETDNS
if "%opt%"=="2" set DNSA=8.8.8.8 && set DNSB=8.8.4.4 && goto SETDNS
if "%opt%"=="3" set DNSA=1.1.1.1 && set DNSB=1.0.0.1 && goto SETDNS
if "%opt%"=="4" set DNSA=208.67.222.222 && set DNSB=208.67.220.220 && goto SETDNS
if "%opt%"=="5" set DNSA=156.154.70.1 && set DNSB=156.154.71.1 && goto SETDNS
if "%opt%"=="b" start "" dns-bench.py google.com
goto LOOP

:: "Ethernet" / "Wi-Fi"
:SETDNS
echo Processing...
netsh interface ipv4 set dns "Ethernet" static %DNSA% >nul 2>&1
netsh interface ipv4 add dns "Ethernet" %DNSB% index=2 >nul 2>&1
goto LOOP
