#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

## Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

## Launch

## Left bar
polybar log -c ~/.config/polybar/current.ini &
#polybar primary -c ~/.config/polybar/workspace.ini &
polybar secondary -c ~/.config/polybar/current.ini &
polybar target -c ~/.config/polybar/current.ini &


## Right bar
#polybar top -c ~/.config/polybar/current.ini &
polybar eth0 -c ~/.config/polybar/current.ini &
polybar eth1 -c ~/.config/polybar/current.ini &
polybar tun0 -c ~/.config/polybar/current.ini &
polybar rpi0 -c ~/.config/polybar/current.ini &
polybar pulseaudio-simple -c ~/.config/polybar/current.ini &
polybar battery -c ~/.config/polybar/current.ini &
polybar network -c ~/.config/polybar/current.ini &
polybar primary -c ~/.config/polybar/current.ini &

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
  wc=`xrandr --query | grep " connected" | cut -d" " -f1 | wc -l`
  echo $wc
  if [ $wc = 1 ]
  then
    WidthValor="13%"
  elif [ $wc = 2 ]
  then
    WidthValor="25%"
  fi
    MONITOR=$m WIDTH=$WidthValor polybar --reload primary -c ~/.config/polybar/workspace.ini  &
  done
else
  WIDTH='13%' polybar --reload primary -c ~/.config/polybar/workspace.ini  &
  
fi


