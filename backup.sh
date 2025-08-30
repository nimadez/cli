#!/bin/bash
#
# Backup

backup_home() {
    > ~/.bash_history
    > ~/.python_history
    > ~/.node_repl_history

    if [ -d "/media/$USER/backup" ]; then
        cd ~
        tar --exclude='./.cache' \
            --exclude='./.config/chromium' \
            --exclude='./.config/VSCodium' \
            --exclude='./.local/share/Trash' \
            --exclude='./.mozilla/firefox/profiles/*/storage/default/*' \
            --exclude='./.mozilla/firefox/profiles/*/storage/permanent/*' \
            --exclude='./.mozilla/firefox/profiles/*/sessionstore-logs/*' \
            --exclude='./.mozilla/firefox/profiles/*/datareporting/archived/*' \
            --exclude='./.venv' \
            -zcvf /media/$USER/backup/data/home_$(date +%Y-%m-%d).tgz .

        echo
        cd ~/.venv
        tar --exclude='__pycache__' \
            -zcvf /media/$USER/backup/data/home_venv.tgz .
    else
        echo "Backup partition is not mounted."
    fi
}

backup_sync() {
    if [ -d "/media/$USER/storage" ]; then
        rsync -aXuv --mkpath --delete --progress \
                --exclude '.cache' \
                --exclude '.config/chromium' \
                --exclude '.config/VSCodium' \
                --exclude '.local/share/Trash' \
                --exclude '.mozilla/firefox/profiles/*/storage/default/*' \
                --exclude '.mozilla/firefox/profiles/*/storage/permanent/*' \
                --exclude '.mozilla/firefox/profiles/*/sessionstore-logs/*' \
                --exclude '.mozilla/firefox/profiles/*/datareporting/archived/*' \
                --exclude '__pycache__' \
                /home/$USER /media/$USER/storage/home

        rsync -aXuv --mkpath --delete --progress /media/$USER/backup/configs    /media/$USER/storage/backup/
        rsync -aXuv --mkpath --delete --progress /media/$USER/backup/data       /media/$USER/storage/backup/
        rsync -aXuv --mkpath --delete --progress /media/$USER/backup/os         /media/$USER/storage/backup/
        rsync -aXuv --mkpath --delete --progress /media/$USER/backup/software   /media/$USER/storage/backup/
        rsync -aXuv --mkpath --delete --progress /media/$USER/backup/workspaces /media/$USER/storage/backup/

        rsync -aXuv --mkpath --delete --progress /media/$USER/local/apps        /media/$USER/storage/local/
        rsync -aXuv --mkpath --delete --progress /media/$USER/local/media       /media/$USER/storage/local/
        rsync -aXuv --mkpath --delete --progress /media/$USER/local/ml          /media/$USER/storage/local/
        rsync -aXuv --mkpath --delete --progress /media/$USER/local/vm          /media/$USER/storage/local/
    else
        echo "Storage partition is not mounted."
    fi
}

if [ $# -eq 1 ]; then
    if [ "$1" = "home" ]; then
        backup_home
    elif [ "$1" = "sync" ]; then
        backup_sync
    else
        echo "Invalid target (home/sync)."
    fi
else
    echo "Usage: backup.sh [home|sync]"
fi
