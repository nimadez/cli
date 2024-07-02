#!/bin/bash

echo 90 | sudo tee /sys/devices/system/cpu/intel_pstate/max_perf_pct
echo 1 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo

echo current max_freq: $(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq)

#echo 4300000 | sudo tee /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
#echo 4300000 | sudo tee /sys/devices/system/cpu/cpufreq/policy1/scaling_max_freq
#echo 4300000 | sudo tee /sys/devices/system/cpu/cpufreq/policy2/scaling_max_freq
#echo 4300000 | sudo tee /sys/devices/system/cpu/cpufreq/policy3/scaling_max_freq
#echo 4300000 | sudo tee /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq
#echo 4300000 | sudo tee /sys/devices/system/cpu/cpufreq/policy5/scaling_max_freq
#echo 4300000 | sudo tee /sys/devices/system/cpu/cpufreq/policy6/scaling_max_freq
#echo 4300000 | sudo tee /sys/devices/system/cpu/cpufreq/policy7/scaling_max_freq
