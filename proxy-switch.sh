#!/bin/bash
#
# Toggle GNOME NetworkManager proxy

curr=$(dconf read /system/proxy/mode)

if [ "$curr" = "'none'" ]; then
    dconf write /system/proxy/mode "'manual'"
    echo -e "\033[92m- MANUAL PROXY -\033[0m"
else
    dconf write /system/proxy/mode "'none'"
    echo -e "\033[91m- NO PROXY -\033[0m"
fi

echo HTTP : $(dconf read /system/proxy/http/host)   $(dconf read /system/proxy/http/port)
echo HTTPS: $(dconf read /system/proxy/https/host)  $(dconf read /system/proxy/https/port)
echo SOCKS: $(dconf read /system/proxy/socks/host)  $(dconf read /system/proxy/socks/port)
