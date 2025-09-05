#!/bin/sh

swaymsg -mt subscribe '["window"]' | jq --unbuffered 'select(.change == "urgent").container.id' | xargs -I{} swaymsg '[con_id={} urgent=latest]' focus &>/dev/null
