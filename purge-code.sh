#!/bin/bash
#
# Purge VSCode/VSCodium

cp ~/.config/VSCodium/User/settings.json ~/.cache

rm -rf ~/.config/VSCodium
mkdir ~/.config/VSCodium
mkdir ~/.config/VSCodium/User

mv ~/.cache/settings.json ~/.config/VSCodium/User
echo Done
