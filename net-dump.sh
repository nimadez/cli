#!/bin/bash

sudo tcpdump -D
read -p "Interface: " i
sudo tcpdump -Q inout -i $i
