#!/bin/bash

echo current max_perf_pct: $(cat /sys/devices/system/cpu/intel_pstate/max_perf_pct)
echo current max_freq: $(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq)
echo current no_turbo: $(cat /sys/devices/system/cpu/intel_pstate/no_turbo)

freq=4300000
#echo 90 | sudo tee /sys/devices/system/cpu/intel_pstate/max_perf_pct
#echo 1 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo
#echo $freq | sudo tee /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
#echo $freq | sudo tee /sys/devices/system/cpu/cpufreq/policy1/scaling_max_freq
#echo $freq | sudo tee /sys/devices/system/cpu/cpufreq/policy2/scaling_max_freq
#echo $freq | sudo tee /sys/devices/system/cpu/cpufreq/policy3/scaling_max_freq
#echo $freq | sudo tee /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq
#echo $freq | sudo tee /sys/devices/system/cpu/cpufreq/policy5/scaling_max_freq
#echo $freq | sudo tee /sys/devices/system/cpu/cpufreq/policy6/scaling_max_freq
#echo $freq | sudo tee /sys/devices/system/cpu/cpufreq/policy7/scaling_max_freq

#sudo nvidia-settings -a [gpu:0]/GPUPowerMizerMode=0 >/dev/null
#sudo nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan:0]/GPUTargetFanSpeed=5" >/dev/null
