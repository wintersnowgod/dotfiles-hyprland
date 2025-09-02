#!/bin/bash

launch() {
    nwg-drawer -ovl -closebtn 'right' -fm 'dolphin' -pbexit 'Logout' -pblock 'Lock' -pbpoweroff 'Shutdown' -pbreboot 'Reboot' -pbsleep 'Sleep' -pbuseicontheme -term 'kitty'
}

killdrawer() {
    pkill nwg-drawer
}

case $1 in
    -l) launch ;;
    -k) killdrawer ;;
esac
