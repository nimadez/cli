#!/bin/bash
#
# Make swap file and mount for next boot

if [ $# -eq 1 ]; then
	if [ $1 -gt 0 ]; then
        read -p "press enter to make swap file ..." p

		# remove
		sudo swapoff /swap.img 2>/dev/null
		sudo rm  /swap.img 2>/dev/null

		# reallocate $1*1024
		sudo fallocate -l $1G /swap.img
		sudo dd if=/dev/zero of=/swap.img bs=1M count=$(($1*1024))
		sudo chmod 600 /swap.img
		sudo mkswap /swap.img

		# activate
		sudo swapon /swap.img

		# status
		sudo swapon -s

		# next boot
		read -p "append to /etc/fstab for next boot (y)? " boot
		if [ "$boot" = "y" ]; then
			echo "# swap file" | sudo tee -a /etc/fstab
			echo "/swap.img    none    swap    sw    0   0" | sudo tee -a /etc/fstab
		fi
    else
        echo help: swap-make.sh [2/4/8/16/32 ...]
    fi
else
    echo help: swap-make.sh [2/4/8/16/32 ...]
fi
