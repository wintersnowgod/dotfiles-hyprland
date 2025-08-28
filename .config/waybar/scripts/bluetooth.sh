#!/bin/bash
manager() {
    blueman-manager
}

toggle () {
    if bluetoothctl show | grep -q "Powered: yes"; then
        bluetoothctl power off
    else
        rfkill unblock bluetooth && bluetoothctl power on
    fi
}

case $1 in
    -t) toggle ;;
    -m) manager ;;
     *) echo "non valid option" ;;
esac
