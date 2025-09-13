#!/bin/bash
#
# Make swap file and mount for next boot

SWAPFILE="/swap.img"

if [ $# -eq 1 ]; then
	read -p "press enter to make swap file ..." p

	# remove
	sudo swapoff "$SWAPFILE" 2>/dev/null
	sudo rm "$SWAPFILE" 2>/dev/null

	# reallocate $1*1024
	echo "please wait ..."
	sudo fallocate -l $1G "$SWAPFILE"
	sudo dd if=/dev/zero of="$SWAPFILE" bs=1M count=$(($1*1024))
	sudo chmod 600 "$SWAPFILE"
	sudo mkswap "$SWAPFILE"

	# activate
	sudo swapon "$SWAPFILE"
	echo "Swap file $SWAPFILE activated."

	# append to /etc/fstab for next boot
	if ! grep -q "$SWAPFILE" "/etc/fstab"; then
		echo "# swap file" | sudo tee -a /etc/fstab
		echo "$SWAPFILE    none    swap    sw    0   0" | sudo tee -a /etc/fstab
		echo "Added swap file entry to /etc/fstab."
	else
		echo "Swap file already present in /etc/fstab."
	fi
else
	echo "Usage: swap-make.sh [GB]"
fi
