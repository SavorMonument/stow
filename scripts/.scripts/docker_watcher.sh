#!/bin/bash

INTERNAL_MONITOR="eDP-1"

# EXTERNAL_MONITOR=$(hyprctl -j monitors | jq -r ".[] | select(.name != \"$INTERNAL_MONITOR\") | .name" | head -n 1)
MONITORS_CONNECTD=$(hyprctl monitors -j | jq 'length')

while true; do
  acpi_listen | while read -r event; do

    case "$event" in *LID\ close*)
    # echo "Lid closed"
    if [ "$MONITORS_CONNECTD" -gt 1 ]; then
      echo "External monitor detected, disabling internal monitor"
      hyprctl keyword monitor "$INTERNAL_MONITOR,disable"
    else
      echo "No external monitor detected, keeping internal monitor enabled"
    fi
    # hyprctl keyword monitor "$INTERNAL_MONITOR,disable"
    ;; *LID\ open*)
    echo "Lid opened"
      hyprctl keyword monitor "$INTERNAL_MONITOR,enable"

    # apply_monitor_config
    ;;
    esac

  done

done

