#!/bin/bash
open_history() {
    if command -v wofi >/dev/null; then
        pkill wofi || cliphist list | wofi --dmenu --width 40% -x 1000 | cliphist decode | wl-copy
    elif command -v rofi >/dev/null; then
        pkill rofi || cliphist list | rofi -dmenu | cliphist decode | wl-copy
    elif command -v dmenu >/dev/null; then
        pkill dmenu || cliphist list | dmenu | cliphist decode | wl-copy
    elif command -v fuzzel >/dev/null; then
        pkill fuzzel || cliphist list | fuzzel --dmenu | cliphist decode | wl-copy
    fi
}

clear_history() {
    cliphist wipe
    notify-send -t 700 "Clipboard history cleared"
}

case "$1" in
    -o)
        open_history
        ;;
    -c)
        clear_history
        ;;
esac

echo '{"alt":"default"}'