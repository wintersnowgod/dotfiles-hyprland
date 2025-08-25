#!/bin/bash
pkill wofi || cliphist list | wofi --dmenu --width 40% -x 1000 | cliphist decode | wl-copy
