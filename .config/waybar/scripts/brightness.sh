#!/bin/bash

# Get current brightness percent
current=$(brightnessctl g)
max=$(brightnessctl m)
percent=$(( current * 100 / max ))

if [[ "$1" == "up" ]]; then
  # Increase brightness by 5%
  new=$(( percent + 5 ))
  if (( new > 100 )); then new=100; fi
elif [[ "$1" == "down" ]]; then
  # Decrease brightness by 5%, but not below 20%
  new=$(( percent - 5 ))
  if (( new < 20 )); then new=20; fi
else
  exit 1
fi

brightnessctl s ${new}%
