#!/bin/bash
#
# Generate new GPG, SSH and SSL keys
# (this will reset all keys)

generate_gpg() {
    # gnome-keyring storage (later it will ask for the default_keyring password via the gui)
    rm -rf ~/.local/share/keyrings 2>/dev/null
    mkdir -p ~/.local/share/keyrings

    rm -rf ~/.gnupg 2>/dev/null
    mkdir ~/.gnupg

    sudo gpg --homedir=/home/$USER/.gnupg -K
    sudo gpg --full-generate-key
    sudo gpg --list-keys

    sudo chown -R $(whoami) ~/.gnupg
    find ~/.gnupg -type f -exec sudo chmod 600 {} \;
    find ~/.gnupg -type d -exec sudo chmod 700 {} \;
}

generate_ssh() {
    address="$(whoami)@$(hostname -d).$(hostname)"

    rm -rf ~/.ssh 2>/dev/null
    mkdir ~/.ssh

    ssh-keygen -t ed25519 -C "$address"
    ssh-keygen -t rsa -b 4096 -C "$address"

    # hardware
    #ssh-keygen -t ed25519-sk -C "$address"
    #ssh-keygen -t ecdsa-sk -C "$address"
}

generate_ssl() {
    rm -rf ~/.ssl 2>/dev/null
    mkdir ~/.ssl

    openssl req -x509 -newkey rsa:4096 -keyout ~/.ssl/key.pem -out ~/.ssl/cert.pem -sha256 -days 365
}

echo "0. Generate GPG keys"
echo "1. Generate SSH keys"
echo "2. Generate SSL keys"
read -p ":  " p

if [ "$p" = "0" ]; then
    generate_gpg
elif [ "$p" = "1" ]; then
    generate_ssh
elif [ "$p" = "2" ]; then
    generate_ssl
else
    exit 0
fi

echo "done"
