#!/bin/bash

ip link
read -p "Interface name: " i
sudo iftop -p -P -i $i
