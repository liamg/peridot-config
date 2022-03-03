#!/bin/bash

# Terminate already running bar instances
killall -q polybar

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      echo "Starting on $m..."
    MONITOR="$m" polybar --reload main & disown
  done
else
  polybar --reload main & disown
fi


