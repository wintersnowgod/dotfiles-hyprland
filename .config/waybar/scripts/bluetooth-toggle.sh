#!/bin/bash
if bluetoothctl show | grep -q "Powered: yes"; then
  bluetoothctl power off
else
  rfkill unblock bluetooth && bluetoothctl power on
fi

