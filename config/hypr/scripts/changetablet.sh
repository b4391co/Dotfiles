#!/usr/bin/env bash

status=`cat ~/.config/hypr/hyprland.conf | grep DP-1 | awk -F '=' '{print $2}'`

if [ $status == "DP-1" ]
then
    # cambia el valor de DP-1 por eDP-1 con sed
    sed -i 's/DP-1/eDP-1/g' ~/.config/hypr/hyprland.conf
else
    # cambia el valor de eDP-1 por DP-1 con sed
    sed -i 's/eDP-1/DP-1/g' ~/.config/hypr/hyprland.conf
fi


