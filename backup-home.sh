#!/bin/bash
#
# Backup home directory to tar archive

BKP=/media/$USER/backup/configs

cp /etc/apt/sources.list $BKP/debian_$(uname -r)_sources.list
apt list | tee $BKP/debian_$(uname -r)_packages.txt
python3.13 -m pip freeze | tee $BKP/debian_$(uname -r)_python313.txt

for dir in ~/.venv/*/; do
    dname=$(basename "$dir")
    ~/.venv/$dname/bin/python -m pip freeze | tee $BKP/python3_venv_$dname.txt
done

cd ~
tar --exclude='./.cache' \
    --exclude='./.config/chromium' \
    --exclude='./.local/share/Trash' \
    --exclude='./.mozilla/firefox/profiles/*/storage/default/*' \
    --exclude='./.mozilla/firefox/profiles/*/storage/permanent/*' \
    --exclude='./.venv' \
    -zcvf /media/$USER/backup/data/home_$(date +%Y-%m-%d).tgz .
