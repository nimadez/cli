#!/bin/bash
#
# Purge

# Temporarily free up memory, but also slowdown as the system rebuilds
purge_mem() {
    sudo sync; echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null
}

purge_swap() {
    sudo swapoff -a && sudo swapon -a
}

# Flush DNS cache and restart networks
purge_net() {
    sudo resolvectl flush-caches
    sudo systemctl restart networking
    sudo systemctl restart NetworkManager
    sleep 3
    # clear rinetd cache
    if ls /etc/init.d/rinetd >/dev/null; then
        sudo systemctl restart rinetd
    fi
}

purge_history() {
    > ~/.bash_history
    > ~/.python_history
    > ~/.node_repl_history
}

purge_apt() {
    sudo apt autoremove --purge
    sudo apt autoclean
    sudo apt clean
}

# Flush __pycache__
purge_pycache() {
    cd /
    sudo python3 -Bc "import pathlib; [p.unlink() for p in pathlib.Path('.').rglob('*.py[co]')]"
    sudo python3 -Bc "import pathlib; [p.rmdir() for p in pathlib.Path('.').rglob('__pycache__')]"
}

purge_temp_cache() {
    rm -rf ~/.cache
    mkdir ~/.cache
    sudo rm -rf /tmp/*
    sudo rm -rf /var/tmp/*
}

echo "0. Memory         (caution)"
echo "1. Swap           (safe)"
echo "2. Network        (safe)"
echo "3. History        (safe)"
echo "4. Temp Soft      (safe)"
echo "5. Temp Hard      (unsafe, incl. ~/.cache)"
read -p ":  " p

if [ "$p" = "0" ]; then
    echo "Purging memory and swap ..."
    purge_mem
    purge_swap
elif [ "$p" = "1" ]; then
    echo "Purging swap ..."
    purge_swap
elif [ "$p" = "2" ]; then
    echo "Purging network ..."
    purge_net
elif [ "$p" = "3" ]; then
    echo "Purging history ..."
    purge_history
    purge_apt
elif [ "$p" = "4" ]; then
    echo "Purging temp (soft) ..."
    purge_history
    purge_apt
    purge_pycache
elif [ "$p" = "5" ]; then
    echo "Purging temp (hard) ..."
    purge_history
    purge_apt
    purge_pycache
    purge_temp_cache
    echo "A system restart or re-login to the desktop is required."
else
    exit 0
fi

echo "done"
