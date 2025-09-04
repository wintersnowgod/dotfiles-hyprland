#!/bin/sh
toggle() {
  if command -v wvkbd-mobintl >/dev/null; then
    if pgrep -x wvkbd-mobintl >/dev/null; then
        pkill wvkbd-mobintl
    elif command -v wvkbd-mobintl >/dev/null; then
        wvkbd-mobintl -L 300 &
    fi
  elif command -v squeekboard >/dev/null; then
    if pgrep -x squeekboard >/dev/null; then
        pkill squeekboard
        fcitx5 &
    elif command -v squeekboard >/dev/null; then
        pkill fcitx5
        squeekboard &
    fi
  fi
}

case "$1" in
  -t|--toggle)
    toggle
    sleep 0.1
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
