#!/bin/bash
#
# Wi-Fi manager using network-manager

open_tui() {
    nmtui
}

toggle_wifi() {
    if [ "$(nmcli radio wifi)" = "enabled" ]; then
        nmcli radio wifi off
        echo "Wi-Fi Radio OFF"
    else
        nmcli radio wifi on
        echo "Wi-Fi Radio ON"
    fi
}

list_devices() {
    nmcli device
}

list_networks() {
    nmcli dev wifi list
}

list_connected() {
    nmcli connection show
}

create_connection() {
    local ssid="$1"
    local pass="$2"
    nmcli device wifi connect $ssid password $pass
}

create_connection_hidden() {
    local ssid="$1"
    local pass="$2"
    nmcli device wifi connect $ssid password $pass hidden yes
}

activate_connection() {
    local name="$1"
    nmcli connection up $name
}

deactivate_connection() {
    local name="$1"
    nmcli connection down $name
}

delete_connection() {
    local name="$1"
    nmcli connection delete $name
}

while true; do

echo "0. Open TUI"
echo "1. Toggle Wi-Fi"
echo "2. List devices"
echo "3. List networks"
echo "4. List connected"
echo "5. Create connection"
echo "6. Create connection (hidden)"
echo "7. Activate connection"
echo "8. Deactivate connection"
echo "9. Delete connection"
read -p ":  " p
echo

if [ "$p" = "0" ]; then
    open_tui
elif [ "$p" = "1" ]; then
    toggle_wifi
elif [ "$p" = "2" ]; then
    list_devices
elif [ "$p" = "3" ]; then
    list_networks
elif [ "$p" = "4" ]; then
    list_connected
elif [ "$p" = "5" ]; then
    read -p "SSID: " ssid
    read -s -p "PASS: " pass
    create_connection $ssid $pass
elif [ "$p" = "6" ]; then
    read -p "SSID: " ssid
    read -s -p "PASS: " pass
    create_connection_hidden $ssid $pass
elif [ "$p" = "7" ]; then
    read -p "NAME: " name
    activate_connection $name
elif [ "$p" = "8" ]; then
    read -p "NAME: " name
    deactivate_connection $name
elif [ "$p" = "9" ]; then
    read -p "NAME: " name
    delete_connection $name
else
    exit 0
fi

echo
done
