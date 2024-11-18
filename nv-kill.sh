#!/bin/bash
#
# Helps CUDA memory by killing PID

nvidia-smi

read -p "PID: " pid
sudo kill -9 $pid
