#!/bin/bash
#
# A simple color picker and palette using Zenity
#
# sh zcolor.sh
# sh zcolor.sh FFFFFF
# result:
#   RGB: rgb(77, 28, 194)
#   RGB: 77, 28, 194
#   RGB: rgb(0.30, 0.11, 0.76)
#   RGB: 0.30, 0.11, 0.76
#   HEX: #4D1CC2
#   HEX: 0x4D1CC2

if [ $# -eq 1 ]; then
    rgb=$(python3 -Bc """print(f'rgb{ tuple(int(\"$1\"[i:i+2], 16) for i in (0, 2, 4)) }')""")
    color=$(zenity --title 'Choose color' --color-selection --color="$rgb")
else
    color=$(zenity --title 'Choose color' --color-selection --color="red")
fi

if [ $color ]; then
    color=$(zenity --color-selection --show-palette --color="$color")
    if [ $color ]; then
        color=$(python3 -Bc "print('$color'.replace('rgb(','').replace('rgba(','').replace(')',''))")

        R=$(echo $color | awk -F, '{print $1}')
        G=$(echo $color | awk -F, '{print $2}')
        B=$(echo $color | awk -F, '{print $3}')
        #A=$(echo $color | awk -F, '{print $4}')

        echo RGB: rgb\($R, $G, $B\)
        echo RGB: $R, $G, $B
        python3 -Bc "print('RGB: rgb({:.3f}, {:.3f}, {:.3f})'.format($R/255, $G/255, $B/255))"
        python3 -Bc "print('RGB: {:.3f}, {:.3f}, {:.3f}'.format($R/255, $G/255, $B/255))"
        python3 -Bc "print('HEX: #{:02X}{:02X}{:02X}'.format($R, $G, $B))"
        python3 -Bc "print('HEX: 0x{:02X}{:02X}{:02X}'.format($R, $G, $B))"
    fi
fi
