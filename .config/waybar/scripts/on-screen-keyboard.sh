#!/bin/sh
if [ "$1" = "-t" ]; then
  if command -v wvkbd-mobintl >/dev/null; then
    if pgrep -x wvkbd-mobintl >/dev/null; then
        pkill wvkbd-mobintl
        echo '{"text":"󰌐", "tooltip": "On Screen Keyboard: OFF"}'
    elif command -v wvkbd-mobintl >/dev/null; then
        wvkbd-mobintl -L 300 &
        echo '{"text":"󰌌", "tooltip": "On Screen Keyboard: ON"}'
    fi
  elif command -v squeekboard >/dev/null; then
    if pgrep -x squeekboard >/dev/null; then
        # If squeekboard is running → stop it, start fcitx5
        pkill squeekboard
        fcitx5 &
        echo '{"text":"󰌐", "tooltip": "On Screen Keyboard: OFF"}'
    elif command -v squeekboard >/dev/null; then
        # Otherwise → stop fcitx5, start squeekboard
        pkill fcitx5
        squeekboard &
        echo '{"text":"󰌌", "tooltip": "On Screen Keyboard: ON"}'
    fi
    pkill -SIGRTMIN+15 waybar
    exit 0
  fi
fi

# -------- Waybar refresh branch --------
if command -v wvkbd-mobintl >/dev/null; then
  if pgrep -x wvkbd-mobintl >/dev/null; then
    echo '{"text":"󰌌", "tooltip": "On Screen Keyboard: ON"}'
  else
    echo '{"text":"󰌐", "tooltip": "On Screen Keyboard: OFF"}'
  fi
elif command -v squeekboard >/dev/null; then
  if pgrep -x squeekboard >/dev/null; then
    echo '{"text":"󰌌", "tooltip": "On Screen Keyboard: ON"}'
  else
    echo '{"text":"󰌐", "tooltip": "On Screen Keyboard: OFF"}'
  fi
fi
