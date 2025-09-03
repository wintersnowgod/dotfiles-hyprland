#!/bin/bash

toggle() {
    if pgrep -x hyprsunset >/dev/null; then
      pkill -x hyprsunset
      notify-send -t 700 "Hyprsunset stopped"
      echo '{"alt":"off","class":"off","tooltip":"Hyprsunset: OFF"}'
    else
      setsid hyprsunset >/dev/null 2>&1 &
      notify-send -t 700 "Hyprsunset started"
      echo '{"alt":"on","class":"on","tooltip":"Hyprsunset: ON"}'
    fi
}

case "$1" in
  -t|--toggle)
    toggle
    sleep 0.1
    pkill -SIGRTMIN+10 waybar
    exit 0
    ;;
esac

# -------- Waybar refresh branch --------
if pgrep -x hyprsunset >/dev/null; then
  echo '{"alt":"on","tooltip":"Hyprsunset: ON"}'
else
  echo '{"alt":"off","tooltip":"Hyprsunset: OFF"}'
fi