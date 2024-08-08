#!/bin/bash

BKP=/media/$USER/backup/configs

cp /etc/apt/sources.list $BKP
apt-mark showmanual | tee $BKP/debian_packages.txt

python3.12 -m pip freeze | tee $BKP/python312_packages.txt
for dir in ~/.venv/*/; do
    dname=$(basename "$dir")
    ~/.venv/$dname/bin/python -m pip freeze | tee $BKP/python3_venv_$dname.txt
done

cd ~
tar --exclude='./.cache' --exclude='./.wine' --exclude='./.venv' --exclude='./.local/share/Trash' -zcvf /media/$USER/backup/data/home.tgz .
