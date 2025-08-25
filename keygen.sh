#!/bin/bash
#
# Generate SSH and SSL keys

address="$(whoami)@$(hostname -d).$(hostname)"

echo;echo "[SSH - ed25519]"
ssh-keygen -t ed25519 -C $address

echo;echo "[SSH - rsa 4096]"
ssh-keygen -t rsa -b 4096 -C $address

echo;echo "[SSH - hardware]"
ssh-keygen -t ed25519-sk -C $address
ssh-keygen -t ecdsa-sk -C $address

echo;echo "[SSL - rsa 4096]"
mkdir ~/.ssl 2>/dev/null
openssl req -x509 -newkey rsa:4096 -keyout ~/.ssl/key.pem -out ~/.ssl/cert.pem -sha256 -days 365
