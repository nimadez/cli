#!/bin/bash
#
# XMon hardware monitor (X11/Wayland)
#
# - Xterm is used for a smaller window and less memory usage (50% less than gnome-terminal)
# - Memory usage is fairly constant, ~5.7 MB for xterm and ~380-480 KB for xmon (due to proper disposal at the end of each loop)
# - CPU usage is from 0.0% to 0.1% and rarely up-to 0.2% (run nvidia-smi only once per loop)
#
# Autostart: hw-xmon-start.sh
# Notice: Do not run this script directly in the terminal, you must use autostart.

TO=1.5      # sleep timeout (less timeout will result in less network accuracy - less time diff)
TZ=2        # set cpu thermal_zone based on your hardware
NI="wlx"    # enp: ethernet | wlx: wifi

IFACE=$(ls /sys/class/net | grep ^$NI)
if ! grep -q "$IFACE" /proc/net/dev; then
    echo "Interface [$IFACE] not found."
    exit 1
fi

echo "Starting ..."
tput civis

while true; do
tput cup 0 0

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
    set -- $(grep "$IFACE" /proc/net/dev | awk '{print $2, $10}')
    rx1=$1
    tx1=$2
    sleep $TO # this sleep is sufficient for the rest
    set -- $(grep "$IFACE" /proc/net/dev | awk '{print $2, $10}')
    rx2=$1
    tx2=$2
    rx_rate=$((rx2 - rx1))
    tx_rate=$((tx2 - tx1))
    echo "↓ $rx_rate ↑ $tx_rate B/s"
}

CPU="CPU  $(get_cpu_usage)%  $(get_cpu_temp)c"
GPU="GPU  $(get_gpu_usage)% $(get_gpu_temp)c  $(get_gpu_mem_usage)% $(get_gpu_fan)%"
MEM="MEM  $(get_mem_usage)% ($(get_swap_usage)%)"
NET="NET  $(get_network_rate)"

#clear # to avoid blinking in Wayland, we fill in the lines instead of erasing everything
printf "\033[96m%s\033[0m%*s\n" "$CPU" $((COLUMNS - ${#CPU})) ""
printf "\033[92m%s\033[0m%*s\n" "$GPU" $((COLUMNS - ${#GPU})) ""
printf "\033[93m%s\033[0m%*s\n" "$MEM" $((COLUMNS - ${#MEM})) ""
printf "\033[97m%s\033[0m%*s"   "$NET" $((COLUMNS - ${#NET})) ""

unset NV CPU GPU MEM NET \
      get_cpu_usage get_cpu_temp \
      get_gpu_usage get_gpu_temp get_gpu_mem_usage get_gpu_fan \
      get_mem_usage get_swap_usage \
      get_network_rate

done

# a trap needed, but given the style of the program, there is no need.
#tput cvvis
