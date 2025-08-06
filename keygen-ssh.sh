#!/bin/bash
#
# Generate ed25519 and rsa-4096 keys

address="$(whoami)@$(hostname)"

echo;echo [ed25519]
ssh-keygen -t ed25519 -C $address

echo;echo [rsa]
ssh-keygen -t rsa -b 4096 -C $address

# It works when the hardware security key is available
#echo;echo [hardware]
#ssh-keygen -t ed25519-sk -C $address
#ssh-keygen -t ecdsa-sk -C $address
