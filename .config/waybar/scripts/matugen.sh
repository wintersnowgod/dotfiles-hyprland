#!/bin/sh
if [ -z "$1" ]; then
    wallpaper=$(hyprctl hyprpaper listloaded)
    matugen image "$wallpaper"
else
    matugen image "$1"
fi
