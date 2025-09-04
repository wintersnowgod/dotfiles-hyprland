#!/bin/bash
toggle () {
    if command -v iio-hyprland >/dev/null; then
        if pgrep -x iio-hyprland >/dev/null; then
            pkill -x iio-hyprland
        else
            setsid iio-hyprland >/dev/null 2>&1 &
        fi
    fi
}

case $1 in
    -t) toggle && sleep 0.1 ;;
esac

 if command -v iio-hyprland >/dev/null; then
    if pgrep -x iio-hyprland >/dev/null; then
    echo '{"alt":"on","tooltip":"Autorotate: ON"}'
    else
    echo '{"alt":"off","tooltip":"Autorotate: Off"}'
    fi
fi