#!/bin/bash
#
# Make Chrome a faster browser by eliminating unwanted/forced downloads
# It reduces internet usage and increases browser loading speed
# (storage space reduced from 20~1000 MB to just 5~10 MB)
#
# I also use these command-line switches:
# --user-data-dir=./.chrome
# --incognito
# --no-first-run
# --disable-plugins
# --disable-default-apps
# --disable-extensions
# --disable-notifications
# --disable-file-system
# --disable-background-networking
# --disable-sync

rm -rf /home/$USER/.chrome/component_crx_cache
mkdir /home/$USER/.chrome/component_crx_cache
chmod -R 400 /home/$USER/.chrome/component_crx_cache

rm -rf /home/$USER/.chrome/hyphen-data
mkdir /home/$USER/.chrome/hyphen-data
chmod -R 400 /home/$USER/.chrome/hyphen-data

rm -rf /home/$USER/.chrome/ZxcvbnData
mkdir /home/$USER/.chrome/ZxcvbnData
chmod -R 400 /home/$USER/.chrome/ZxcvbnData

rm -rf /home/$USER/.chrome/OnDeviceHeadSuggestModel
mkdir /home/$USER/.chrome/OnDeviceHeadSuggestModel
chmod -R 400 /home/$USER/.chrome/OnDeviceHeadSuggestModel

rm -rf /home/$USER/.chrome/optimization_guide_model_store
mkdir /home/$USER/.chrome/optimization_guide_model_store
chmod -R 400 /home/$USER/.chrome/optimization_guide_model_store

rm -rf /home/$USER/.chrome/Default/Download\ Service
mkdir /home/$USER/.chrome/Default/Download\ Service
chmod -R 400 /home/$USER/.chrome/Default/Download\ Service

echo Done
