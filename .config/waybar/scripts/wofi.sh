#!/bin/bash
choice=$(printf "Apps\nRun" | wofi --dmenu --prompt "Select:" --width 10% --height 8% -x 0 -y 0)
case $choice in
    Apps)    wofi --show drun --width 40% --height 60% -x 0 -y 0;;
    Run)     wofi --show run --width 40% --height 60% -x 0 -y 0;;
esac
