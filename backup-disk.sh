#!/bin/bash

read -p "press enter to backup disk ..." p

rsync -axuv --mkpath --delete --progress --exclude '.cache' --exclude '.local/share/Trash' /home/$USER /media/$USER/storage/home

rsync -axuv --mkpath --delete --progress /media/$USER/backup/configs    /media/$USER/storage/backup/
rsync -axuv --mkpath --delete --progress /media/$USER/backup/data       /media/$USER/storage/backup/
rsync -axuv --mkpath --delete --progress /media/$USER/backup/os         /media/$USER/storage/backup/
rsync -axuv --mkpath --delete --progress /media/$USER/backup/software   /media/$USER/storage/backup/
rsync -axuv --mkpath --delete --progress /media/$USER/backup/workspaces /media/$USER/storage/backup/

rsync -axuv --mkpath --delete --progress /media/$USER/local/apps        /media/$USER/storage/local/
rsync -axuv --mkpath --delete --progress /media/$USER/local/media       /media/$USER/storage/local/
rsync -axuv --mkpath --delete --progress /media/$USER/local/ml          /media/$USER/storage/local/
#rsync -axuv --mkpath --delete --progress /media/$USER/local/vm         /media/$USER/storage/local/
rsync -axuv --mkpath --delete --progress /media/$USER/local/workspace   /media/$USER/storage/local/
