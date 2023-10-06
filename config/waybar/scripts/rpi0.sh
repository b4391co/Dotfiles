#!/bin/sh

IFACE=$(/usr/sbin/ifconfig | grep rpi0 | awk '{print $1}' | tr -d ':')
if [ "$IFACE" = "rpi0" ]; then
    IP=$(ifconfig rpi0 | grep "inet " | awk '{print $2}')
    if [ "$IP" != "" ]; then
        echo " rpi: $(/usr/sbin/ifconfig rpi0 | grep "inet " | awk '{print $2}')"
    else
        echo " rpi: Disconnected"
    fi
else
    echo " rpi: Disconnected"
fi
