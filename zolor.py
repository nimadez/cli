#!/usr/bin/env python3
#
# A simple color picker
# (includes alpha if available)
#
# Dependencies: zenity

import sys, subprocess

cmd = f'zenity --title "Choose color" --color-selection 2>/dev/null'
res = None
try:
    res = subprocess.check_output(cmd, shell=True, text=True)
except subprocess.CalledProcessError as err:
    sys.exit(1)
except KeyboardInterrupt:
    sys.exit(0)

rgb = res.strip().replace('rgb(', '').replace('rgba(', '').replace(')', '').split(',')
r = int(rgb[0])
g = int(rgb[1])
b = int(rgb[2])

if len(rgb) == 3:
    print("RGB:", f"rgb({r}, {g}, {b})")
    print("RGB:", "rgb({:.3f}, {:.3f}, {:.3f})".format(r/255, g/255, b/255))
    print("HEX:", "#{:02X}{:02X}{:02X}".format(r, g, b))
    print("HEX:", "0x{:02X}{:02X}{:02X}".format(r, g, b))
else:
    a = float(rgb[3])
    hexa = round(min(max(a, 0), 1) * 255)
    print("RGB:", f"rgba({r}, {g}, {b}, {a})")
    print("RGB:", "rgba({:.3f}, {:.3f}, {:.3f}, {:.3f})".format(r/255, g/255, b/255, a))
    print("HEX:", "#{:02X}{:02X}{:02X}{:02X}".format(r, g, b, hexa))
    print("HEX:", "0x{:02X}{:02X}{:02X}{:02X}".format(r, g, b, hexa))
