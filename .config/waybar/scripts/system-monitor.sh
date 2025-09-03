#!/bin/bash
TERMINAL=$(< ~/.config/waybar/scripts/terminal.sh)

missioncenter \
  || flatpak run io.missioncenter.MissionCenter \
  || $TERMINAL -e htop \
  || $TERMINAL -e bashtop \
  || $TERMINAL -e btop