#!/bin/sh

IFACE1=$(ip link show | grep '2: ' | awk '{print $2}' | awk -F ':' '{print $1}')
IFACE2=$(ip link show | grep '3: ' | awk '{print $2}' | awk -F ':' '{print $1}')
STATUS1=$(ip link show |  grep '2: ' | awk -F 'state' '{print $2}' | awk '{print $1}')
STATUS2=$(ip link show |  grep '3: ' | awk -F 'state' '{print $2}' | awk '{print $1}')

if [ "$STATUS1" = "UP" ]
then
    IP=$(ifconfig $IFACE1 | grep "inet " | awk '{print $2}')
    if [ "$IP" != "" ]; then
        echo " eth: $(/usr/sbin/ifconfig $IFACE1 | grep "inet " | awk '{print $2}')"
    else
        echo " eth: Disconnected"
    fi
elif [ "$STATUS2" = "UP" ]
then
    IP=$(ifconfig $IFACE2 | grep "inet " | awk '{print $2}')
    if [ "$IP" != "" ]; then
        echo "  wlan: $(/usr/sbin/ifconfig $IFACE2 | grep "inet " | awk '{print $2}')"
    else
        echo "  wlan: Disconnected"
    fi
else
    echo " eth: Disconnected"
fi