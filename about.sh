#!/bin/bash

hostnamectl
read -p "press enter to continue ..." p
echo; df -h
read -p "press enter to continue ..." p
echo; ip link
read -p "press enter to continue ..." p
echo; lshw -short
read -p "press enter to continue ..." p
echo; nvidia-smi
read -p "press enter to show hardware details ..." p
echo; sudo lshw -notime
