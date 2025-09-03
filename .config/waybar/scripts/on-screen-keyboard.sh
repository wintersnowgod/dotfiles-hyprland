#!/bin/sh
toggle() {
  if command -v wvkbd-mobintl >/dev/null; then
    if pgrep -x wvkbd-mobintl >/dev/null; then
        pkill wvkbd-mobintl
        echo '{"alt":"off", "tooltip": "On Screen Keyboard: OFF"}'
    elif command -v wvkbd-mobintl >/dev/null; then
        wvkbd-mobintl -L 300 &
        echo '{"alt":"on", "tooltip": "On Screen Keyboard: ON"}'
    fi
  elif command -v squeekboard >/dev/null; then
    if pgrep -x squeekboard >/dev/null; then
        pkill squeekboard
        fcitx5 &
        echo '{"alt":"off", "tooltip": "On Screen Keyboard: OFF"}'
    elif command -v squeekboard >/dev/null; then
        pkill fcitx5
        squeekboard &
        echo '{"alt":"on", "tooltip": "On Screen Keyboard: ON"}'
    fi
  fi
}

case "$1" in
  -t|--toggle)
    toggle
    sleep 0.1
    pkill -SIGRTMIN+15 waybar
    exit 0
    ;;
esac

# -------- Waybar refresh branch --------
if command -v wvkbd-mobintl >/dev/null; then
  if pgrep -x wvkbd-mobintl >/dev/null; then
    echo '{"alt":"on", "tooltip": "On Screen Keyboard: ON"}'
  else
    echo '{"alt":"off", "tooltip": "On Screen Keyboard: OFF"}'
  fi
elif command -v squeekboard >/dev/null; then
  if pgrep -x squeekboard >/dev/null; then
    echo '{"alt":"on", "tooltip": "On Screen Keyboard: ON"}'
  else
    echo '{"alt":"off", "tooltip": "On Screen Keyboard: OFF"}'
  fi
fi
