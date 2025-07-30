#!/bin/bash
#
# Generate a bitcoin address

~/.venv/btcgen/bin/python3 -Bc """from bitcoinaddress import Wallet; print(Wallet())"""
