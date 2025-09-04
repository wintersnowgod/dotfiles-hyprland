#!/bin/bash

toggle() {
    if pgrep -x hyprsunset >/dev/null; then
      pkill -x hyprsunset
      notify-send -t 700 "Hyprsunset stopped"
    else
      setsid hyprsunset >/dev/null 2>&1 &
      notify-send -t 700 "Hyprsunset started"
    fi
}

case "$1" in
  -t)
    toggle
    sleep 0.1
    ;;
esac

# -------- Waybar refresh branch --------
if pgrep -x hyprsunset >/dev/null; then
  echo '{"alt":"on","tooltip":"Hyprsunset: ON"}'
else
  echo '{"alt":"off","tooltip":"Hyprsunset: OFF"}'
fi