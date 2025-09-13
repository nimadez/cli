#!/bin/bash
#
# Run and list /cli scripts
#
# Notice: You cannot have two scripts with the same name but with
# different extensions, unless you call with an extension.
# (shebang is required for all scripts)
#
# $ cli script
# $ cli script.sh
# $ cli script.py
# $ cli install/script
# $ cli install/script.sh

DIR=$(dirname $(realpath "$0"))

if [ $# -lt 1 ]; then
    printf "\033[96m$ Debian Assistant CLI - github.com/nimadez/cli\033[0m\n"
    ls --group-directories-first --ignore="docs" --ignore="media" --ignore="LICENSE" --ignore="README.md" --color=always $DIR
    echo "Usage: cli <script|script.ext> [args...]"
    echo "       cli <directory/script> [args...]"
    exit 0
fi

SCR_NAME="$1"
shift
SCR_ARGS="$@"

# If calling script with a directory
DNAME=$(dirname "$SCR_NAME")
FNAME=$(basename "$SCR_NAME")
if [ ! "$DNAME" = "." ]; then
    DIR="$DIR/$DNAME"
    SCR_NAME="$FNAME"
fi

# If script exists with extension
SCR_PATH="$DIR/$SCR_NAME"
if [ -f "$SCR_PATH" ]; then
    case "${SCR_NAME##*.}" in
        "sh") bash "$SCR_PATH" "$@" ;;
        "py") python3 "$SCR_PATH" "$@" ;;
        "js") node "$SCR_PATH" "$@" ;;
        "pl") perl "$SCR_PATH" "$@" ;;
        "rb") ruby "$SCR_PATH" "$@" ;;
    esac
    exit $?
fi

# If script is not found with any extension
SCR_PATH=$(find "$DIR" -maxdepth 1 -type f -name "$SCR_NAME.*" 2>/dev/null)
case "${SCR_PATH##*.}" in
    "sh") bash "$SCR_PATH" "$@" ;;
    "py") python3 "$SCR_PATH" "$@" ;;
    "js") node "$SCR_PATH" "$@" ;;
    "pl") perl "$SCR_PATH" "$@" ;;
    "rb") ruby "$SCR_PATH" "$@" ;;
    *) echo "Error: Script '$SCR_NAME' not found in $DIR directory." ;;
esac
