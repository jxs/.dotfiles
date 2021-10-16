#!/bin/sh

COMMAND=$1
MUTED=$(pamixer --get-mute)
ICON_VOLUME="/usr/share/icons/Papirus/48x48/status/notification-audio-volume-high.svg"
ICON_MUTED="/usr/share/icons/Papirus/48x48/status/notification-audio-volume-muted.svg"

show_notification () {
  volume=$(pamixer --get-volume)
  muted=$(pamixer --get-mute)
  num=$(( volume / 10 ))
  remain=$(( 10 - num ))
  fill=""
  empty=""
  icon=$ICON_VOLUME
  if [ "$muted" = "true" ]; then remain=10; fi
  if [ "$muted" = "true" ]; then icon=$ICON_MUTED; fi
  if [ "$num" -gt 0 ] && [ "$muted" = "false" ]; then fill=$(printf ' %.0s' $(seq $num)); fi
  if [ "$remain" -gt 0 ]; then empty=$(printf '%.0s' $(seq $remain)); fi
  notify-send.sh --replace-file=/tmp/volume-notification -c "SYSTEM_NOTIFICATION" -i $icon -t 2000 "Volume ${volume}%" "${fill}${empty}"
}

case $COMMAND in

  "up")
    if [ "$MUTED" = "false" ]; then pactl set-sink-volume @DEFAULT_SINK@ +5%; fi
    show_notification
    ;;

  "down")
    if [ "$MUTED" = "false" ]; then pactl set-sink-volume @DEFAULT_SINK@ -5%; fi
    show_notification
    ;;

  "toggle")
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    show_notification
    ;;

  *)
    pamixer --get-volume-human
    ;;
esac
