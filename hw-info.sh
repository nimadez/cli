#!/bin/bash
#
# Display basic hardware info
#
# - xterm used for smaller window
# - best with "$ watchdog 1 hw-info"
# - network interface is set to wifi (wlx), use (enp) for ethernet
#
# autostart: (xterm required)
# xterm -fa "Droid Sans Mono" -fs 10 -geometry 28x4+1910+0 -bg Grey15 -T "HW Info" -e sh -c "watch -t -c -n 1 hw-info" &

get_cpu_usage() {
    cpu_usage=$(awk -v a="$(awk '/cpu /{print $2+$4,$2+$4+$5}' /proc/stat; sleep 0.3)" '/cpu /{split(a,b," "); print 100*($2+$4-b[1])/($2+$4+$5-b[2])}' /proc/stat)
    printf "%.1f" "$cpu_usage"
}

get_cpu_temp() {
    cpu_temp=$(cat /sys/devices/virtual/thermal/thermal_zone2/temp)
    echo "$(($cpu_temp / 1000))"
}

get_gpu_usage() {
    gpu_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
    printf "%.1f" "$gpu_usage"
}

get_gpu_mem_usage() {
    gpu_mem=$(nvidia-smi --query-gpu=memory.total,memory.used --format=csv,noheader,nounits -i 0)
    total=$(echo "$gpu_mem" | awk -F',' '{print $1}')
    used=$(echo "$gpu_mem" | awk -F',' '{print $2}')
    gpu_mem=$(awk "BEGIN {printf \"%.1f\", ($used/$total)*100}") # percentage
    printf "%.1f" "$gpu_mem"
}

get_gpu_temp() {
    gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)
    echo "$gpu_temp"
}

get_gpu_fan() {
    gpu_fan=$(nvidia-smi --query-gpu=fan.speed --format=csv,noheader | tr -d ' %')
    echo "$gpu_fan"
}

get_ram_usage() {
    mem_info=$(free | grep Mem)
    total=$(echo "$mem_info" | awk '{print $2}')
    used=$(echo "$mem_info" | awk '{print $3}')
    ram_usage=$(awk "BEGIN {printf \"%.1f\", ($used/$total)*100}")
    echo "$ram_usage"
}

get_swap_usage() {
    swap_info=$(free | grep Swap)
    total=$(echo "$swap_info" | awk '{print $2}')
    used=$(echo "$swap_info" | awk '{print $3}')
    if [ "$total" -eq 0 ]; then # avoid division by zero
        echo "0.0"
    else
        swap_usage=$(awk "BEGIN {printf \"%.1f\", ($used/$total)*100}")
        echo "$swap_usage"
    fi
}

get_network_rate() {
    iface=$(ls /sys/class/net | egrep -i ^wlx)
    read rx1 tx1 < <(grep "$iface" /proc/net/dev | awk '{print $2, $10}')
    sleep 1 # this sleep is sufficient for other cases as well
    read rx2 tx2 < <(grep "$iface" /proc/net/dev | awk '{print $2, $10}')
    rx_rate=$((rx2 - rx1))
    tx_rate=$((tx2 - tx1))
    echo "↓ $rx_rate ↑ $tx_rate B/s"
}

CPU="CPU $(get_cpu_usage)% $(get_cpu_temp)c"
GPU="GPU $(get_gpu_usage)% $(get_gpu_temp)c | $(get_gpu_mem_usage)% | $(get_gpu_fan)%"
MEM="MEM $(get_ram_usage)% | SWP $(get_swap_usage)%"
NET="NET $(get_network_rate)"

echo -e "\033[96m$CPU\033[0m"
echo -e "\033[92m$GPU\033[0m"
echo -e "\033[93m$MEM\033[0m"
echo -e "\033[97m$NET\033[0m"
