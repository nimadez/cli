#!/bin/bash
#
# XMon: Basic hardware monitor
#
# - xterm is used for a smaller window and less memory consumption (50% less than gnome-terminal)
# - This is more efficient than the previous GTop-based gnome extension + has more features
#
# Dependencies: xterm, wmctrl
# Autostart: hw-xmon-start.sh

TO=1.5
TZ=2        # set cpu thermal_zone based on your hardware
NI="wlx"    # ethernet (enp) wifi (wlx)

echo "Starting ..."
iface=$(ls /sys/class/net | grep ^$NI)
tput civis

for (( ; ; )) do

NV=$(nvidia-smi --query-gpu=utilization.gpu,memory.total,memory.used,temperature.gpu,fan.speed --format=csv,noheader,nounits)

get_cpu_usage() {
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4 + $6}')
    printf "%.1f" "$cpu_usage"
}

get_cpu_temp() {
    cpu_temp=$(cat /sys/devices/virtual/thermal/thermal_zone$TZ/temp)
    echo "$(($cpu_temp / 1000))"
}

get_gpu_usage() {
    gpu_usage=$(echo "$NV" | awk -F',' '{print $1}')
    printf "%.1f" "$gpu_usage"
}

get_gpu_mem_usage() {
    total=$(echo "$NV" | awk -F',' '{print $2}')
    used=$(echo "$NV" | awk -F',' '{print $3}')
    gpu_mem=$(awk "BEGIN {printf \"%.1f\", ($used/$total)*100}")
    printf "%.1f" "$gpu_mem"
}

get_gpu_temp() {
    gpu_temp=$(echo "$NV" | awk -F',' '{print $4}')
    echo "$gpu_temp"
}

get_gpu_fan() {
    gpu_fan=$(echo "$NV" | awk -F',' '{print $5}')
    echo "$gpu_fan"
}

get_mem_usage() {
    mem_info=$(free | grep Mem)
    total=$(echo "$mem_info" | awk '{print $2}')
    used=$(echo "$mem_info" | awk '{print $3}')
    mem_usage=$(awk "BEGIN {printf \"%.1f\", ($used/$total)*100}")
    echo "$mem_usage"
}

get_swap_usage() {
    swap_info=$(free | grep Swap)
    total=$(echo "$swap_info" | awk '{print $2}')
    if [ "$total" -eq 0 ]; then
        echo "0.0"
    else
        used=$(echo "$swap_info" | awk '{print $3}')
        swap_usage=$(awk "BEGIN {printf \"%.1f\", ($used/$total)*100}")
        echo "$swap_usage"
    fi
}

get_network_rate() {
    read rx1 tx1 < <(grep "$iface" /proc/net/dev | awk '{print $2, $10}')
    sleep $TO # this sleep is sufficient for the rest
    read rx2 tx2 < <(grep "$iface" /proc/net/dev | awk '{print $2, $10}')
    rx_rate=$((rx2 - rx1))
    tx_rate=$((tx2 - tx1))
    echo "↓ $rx_rate ↑ $tx_rate B/s"
}

CPU="CPU  $(get_cpu_usage)%  $(get_cpu_temp)c"
GPU="GPU  $(get_gpu_usage)% $(get_gpu_temp)c  $(get_gpu_mem_usage)% $(get_gpu_fan)%"
MEM="MEM  $(get_mem_usage)% ($(get_swap_usage)%)"
NET="NET  $(get_network_rate)"

clear
echo -ne "\033[96m$CPU\033[0m\n"
echo -ne "\033[92m$GPU\033[0m\n"
echo -ne "\033[93m$MEM\033[0m\n"
echo -ne "\033[97m$NET\033[0m"

unset NV CPU GPU MEM NET \
      get_cpu_usage get_cpu_temp \
      get_gpu_usage get_gpu_temp get_gpu_mem_usage get_gpu_fan \
      get_mem_usage get_swap_usage \
      get_network_rate

done
