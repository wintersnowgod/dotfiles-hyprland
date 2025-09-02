#!/bin/bash

launch() {
    nwg-dock-hyprland -d -hd 500 -i 48 -lp start -c "$HOME/.config/waybar/scripts/drawer.sh -l" -p bottom -a center -ico '/usr/share/icons/Papirus-Dark/64x64/categories/distributor-logo-archlinux.svg'
}

toggle() {
    pkill -SIGRTMIN+1 -f nwg-dock-hyprland
}

killdock() {
    pkill -f nwg-dock-hyprland
}

case $1 in
    -l) launch ;;
    -t) toggle ;;
    -k) killdock ;;
esac
