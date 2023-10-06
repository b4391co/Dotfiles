#!/bin/bash
if [ $FS = 0 ]
then
    killall -q polybar
    export FS=1
else
    sh ~/.config/polybar/launch.sh &
    export FS=0
fi