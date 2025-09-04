#!/usr/bin/bash

while true; do
    if pgrep -x kded6 >/dev/null 2>&1; then
        pkill -x kded6 >/dev/null 2>&1
    fi
    sleep 1
done