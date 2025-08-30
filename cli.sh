#!/bin/bash
#
# Run and list /cli scripts

CONFIG="/usr/local/bin/cli.cfg"
if [ ! -r "$CONFIG" ]; then
    echo "Error: CLI is not installed, execute 'cd cli && sh cli-install.sh'."
    exit 1
fi

SRC_DIR=$(< "$CONFIG")

if [ $# -lt 1 ]; then
    echo -e "\033[96m$ Debian Assistant CLI - https//github.com/nimadez/cli\033[0m"
    ls --group-directories-first --ignore="docs" --ignore="media" --ignore="LICENSE" --ignore="README.md" --color=always "$SRC_DIR"
    echo "Usage: cli <script|script.ext> [args...]"
    echo "       cli <install/script> [args...]"
    echo "       cli <patch/script> [args...]"
    echo;exit 1
fi

SCRIPT_NAME="$1"
shift
SCRIPT_ARGS="$@"

# Check if script exists with extensions
for ext in .sh .py .js .pl .rb; do
    if [ -f "$SRC_DIR/$SCRIPT_NAME$ext" ]; then
        SCRIPT_PATH="$SRC_DIR/$SCRIPT_NAME$ext"
        case "$ext" in
            .sh)
                bash "$SCRIPT_PATH" "$@"
                ;;
            .py)
                python3 "$SCRIPT_PATH" "$@"
                ;;
            .js)
                node "$SCRIPT_PATH" "$@"
                ;;
            .pl)
                perl "$SCRIPT_PATH" "$@"
                ;;
            .rb)
                ruby "$SCRIPT_PATH" "$@"
                ;;
        esac
        exit $?
    fi
done

# If script is not found with any extension (shebang check)
if [ -f "$SRC_DIR/$SCRIPT_NAME" ]; then
    SHEBANG=$(head -n 1 "$SRC_DIR/$SCRIPT_NAME")
    if [[ $SHEBANG == *bash* ]]; then
        bash "$SRC_DIR/$SCRIPT_NAME" "$@"
    elif [[ $SHEBANG == *python3* ]]; then
        python3 "$SRC_DIR/$SCRIPT_NAME" "$@"
    elif [[ $SHEBANG == *node* ]]; then
        node "$SRC_DIR/$SCRIPT_NAME" "$@"
    elif [[ $SHEBANG == *perl* ]]; then
        perl "$SRC_DIR/$SCRIPT_NAME" "$@"
    elif [[ $SHEBANG == *ruby* ]]; then
        ruby "$SRC_DIR/$SCRIPT_NAME" "$@"
    else
        echo "Error: Unknown script type."
        exit 1
    fi
    exit $?
fi

echo "Error: Script '$SCRIPT_NAME' not found in $SRC_DIR directory."
exit 1
