#!/bin/bash
#
# Set nvidia GPU fan speed

if [ $# -eq 2 ]; then
    if [ "$2" = "0" ]; then
        sudo nvidia-settings -a "[gpu:$1]/GPUFanControlState=0"
    else
        sudo nvidia-settings -a "[gpu:$1]/GPUFanControlState=1" -a "[fan:0]/GPUTargetFanSpeed=$2"
    fi    
else
    echo "Usage: hw-fan-nv.sh [gpu_num] [speed% 0=OFF]"
fi
