#!/bin/bash

echo 90 | sudo tee /sys/devices/system/cpu/intel_pstate/max_perf_pct
