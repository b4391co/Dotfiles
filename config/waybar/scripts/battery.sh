#!/bin/sh

bat=$((`acpi | grep -v "unavailable" | awk -F ',' '{print $2}' | awk -F '%' '{print $1}'`))
status=`acpi | grep -v "unavailable" | awk '{print $3}' | awk -F ',' '{print $1}'`
if [ "$status" == "Charging" ]
then
    echo "%{F#00ff44} $bat%"
fi
if [ "$status" == "Not" ]
then
    echo "%{F#00ff44} $bat%"
fi
if [ $bat = 0 ]
then
    echo "%{F#00ff44} 100%"
fi
if [ $bat -le 10 ]
then
    echo "%{F#ff1500} $bat%"
elif [ $bat -le 20 ]
then
    echo "%{F#ff1500} $bat%"
elif [ $bat -le 30 ]
then
    echo "%{F#ffbb00} $bat%"
elif [ $bat -le 40 ]
then
    echo "%{F#ffbb00} $bat%"
elif [ $bat -le 40 ]
then
    echo "%{F#f2ff00} $bat%"
elif [ $bat -le 50 ]
then
    echo "%{F#f2ff00} $bat%"
elif [ $bat -le 60 ]
then
    echo "%{F#9dff00} $bat%"
elif [ $bat -le 70 ]
then
    echo "%{F#9dff00} $bat%"
elif [ $bat -le 80 ]
then
    echo "%{F#00ff44} $bat%"
elif [ $bat -le 90 ]
then
    echo "%{F#00ff44} $bat%"
elif [ $bat -le 100 ]
then
    echo "%{F#00ff44} $bat%"
fi



