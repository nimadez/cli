#!/bin/bash
#
# Backup

read -p "press enter to backup disk ..." p

# Backup home partition to tar archive

if [ -d "/media/$USER/backup" ]; then
    cd ~
    tar --exclude='./.cache' \
        --exclude='./.config/chromium' \
        --exclude='./.local/share/Trash' \
        --exclude='./.mozilla/firefox/profiles/*/storage/default/*' \
        --exclude='./.mozilla/firefox/profiles/*/storage/permanent/*' \
        --exclude='./.venv' \
        -zcvf /media/$USER/backup/data/home_$(date +%Y-%m-%d).tgz .
else
    echo "Backup partition is not mounted."
fi

# Sync partitions

if [ -d "/media/$USER/storage" ]; then
    rsync -aXuv --mkpath --delete --progress \
            --exclude '.cache' \
            --exclude '.config/chromium' \
            --exclude '.local/share/Trash' \
            --exclude '.mozilla/firefox/profiles/*/storage/default/*' \
            --exclude '.mozilla/firefox/profiles/*/storage/permanent/*' \
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
