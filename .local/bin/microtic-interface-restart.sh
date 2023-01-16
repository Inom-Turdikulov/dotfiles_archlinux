#!/bin/sh
# Automatically restart microtik interface

notify-send 'Restarting microtik router, need wait at least 17 seconds!' -u critical
password=$(pass <enter password entry>)
sshpass -p $password ssh admin@192.168.88.1 <<EOF
/interface disable lte1; delay 5; /interface enable lte1
EOF
notify-send 'Restarting done!' -u critical

