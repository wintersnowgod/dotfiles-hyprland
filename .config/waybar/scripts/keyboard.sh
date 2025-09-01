#!/bin/sh
if [ "$1" = "toggle" ]; then
    if pgrep -x squeekboard >/dev/null; then
        # If squeekboard is running → stop it, start fcitx5
        pkill squeekboard
        fcitx5 &
        echo '󰌐'
    elif command -v squeekboard >/dev/null; then
        # Otherwise → stop fcitx5, start squeekboard
        pkill fcitx5
        squeekboard &
        echo '󰌌'
    fi
fi

# -------- Waybar refresh branch --------
if pgrep -x squeekboard >/dev/null; then
  echo '{"text":"󰌌", "tooltip": "On Screen Keyboard: ON"}'
else
  echo '{"text":"󰌐", "tooltip": "On Screen Keyboard: OFF"}'
fi

pkill -SIGRTMIN+15 waybar
