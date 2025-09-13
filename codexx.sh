#!/bin/bash
#
# codex.sh with GPU enabled

DIR=$(dirname $(realpath "$0"))

cp $DIR/codex.sh ~/.cache/codex.sh
sed -i 's/USE_GPU=0/USE_GPU=1/g' ~/.cache/codex.sh

echo "[GPU]"
bash ~/.cache/codex.sh $*
