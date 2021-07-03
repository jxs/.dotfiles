#!/bin/sh

COMMAND=$1
MUTED=$(pamixer --get-mute)

show_notification () {
  volume=$(pamixer --get-volume)
  muted=$(pamixer --get-mute)
  if [ "$muted" = "true" ]; then
      notify-send.sh --replace-file=/tmp/volume-notification -c "SYSTEM_NOTIFICATION" -t 2000 "";
  else
      notify-send.sh --replace-file=/tmp/volume-notification -c "SYSTEM_NOTIFICATION" -t 2000 "  ${volume}%" --hint="int:value:${volume}";
  fi
}

case $COMMAND in

  "up")
    if [ "$MUTED" = "false" ]; then
        pactl set-sink-volume @DEFAULT_SINK@ +5%;
        show_notification;
    fi
    ;;

  "down")
    if [ "$MUTED" = "false" ]; then
        pactl set-sink-volume @DEFAULT_SINK@ -5%;
        show_notification;
    fi
    ;;

  "toggle")
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    show_notification
    ;;

  *)
    pamixer --get-volume-human
    ;;
esac
