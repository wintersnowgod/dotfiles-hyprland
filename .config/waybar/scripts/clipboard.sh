#!/bin/bash
open_history() {
    pkill wofi || cliphist list | wofi --dmenu --width 40% -x 1000 | cliphist decode | wl-copy
}

clear_history() {
    cliphist wipe
    notify-send "Clipboard history cleared"
}

case "$1" in
    -o)
        open_history
        ;;
    -c)
    clear_history
    ;;
esac