#!/bin/bash
#
# codex.sh with GPU enabled

CONFIG="/usr/local/bin/cli.cfg"
if [ ! -r "$CONFIG" ]; then
    echo "Error: CLI is not installed, execute 'cd cli && sh cli-install.sh'."
    exit 1
fi

SRC_DIR=$(< "$CONFIG")

cp $SRC_DIR/codex.sh ~/.cache/codex.sh
sed -i 's/USE_GPU=0/USE_GPU=1/g' ~/.cache/codex.sh

echo "[GPU]"
bash ~/.cache/codex.sh $*
