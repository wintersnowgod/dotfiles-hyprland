#!/bin/bash

if [ "$1" = "toggle" ]; then
  if pgrep -x hyprsunset >/dev/null; then
    pkill hyprsunset &
    notify-send -t 700 "Hyprsunset stopped"
  else
    setsid hyprsunset >/dev/null 2>&1 &
    notify-send -t 700 "Hyprsunset started"
  fi
fi

# -------- Waybar refresh branch --------
if pgrep -x hyprsunset >/dev/null; then
  echo '{"text":"󱩌"}'
else
  echo '{"text":"󰹏"}'
fi

# tell waybar to refresh this module
pkill -SIGRTMIN+10 waybar
