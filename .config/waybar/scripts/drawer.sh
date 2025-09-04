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

ID=$(cat /etc/os-release | grep '^ID=' | head -n1 | cut -d= -f2 | tr -d '"')
case "$ID" in
    arch)
        echo '{"alt":"arch"}'
        ;;
    debian)
        echo '{"alt":"debian"}'
        ;;
    ubuntu)
        echo '{"alt":"ubuntu"}'
        ;;
    linuxmint)
        echo '{"alt":"mint"}'
        ;;
    pop)
        echo '{"alt":"pop"}'
        ;;
    *)
        echo '{"alt":"default"}'
        ;;
esac