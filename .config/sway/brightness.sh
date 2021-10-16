#!/bin/sh

COMMAND=$1

ICON="$HOME/.local/share/icons/brightness-adjust.svg"
SYMBOL_FULL=' '
SYMBOL_EMPTY=$SYMBOL_FULL

show_notification () {
  max=$(brightnessctl m)
  value=$(brightnessctl g)

  full=""
  empty=""

  percentage=$((value * 150 / max))
  full_size=$(( percentage / 10 ))
  empty_size=$(( 15 - full_size ))

  if [ "$full_size" -gt 0 ]; then full=$(printf "${SYMBOL_FULL}%.0s" $(seq $full_size)); fi
  if [ "$empty_size" -gt 0 ]; then empty=$(printf "${SYMBOL_EMPTY}%.0s" $(seq $empty_size)); fi

  message="<span font='13'><b>"`
    `"<span foreground='#e5e9f0'>${full}</span>"`
    `"<span foreground='#3b4252'>${empty}</span>"`
  `"</b></span>"

  notify-send.sh \
    --replace-file=/tmp/brightness-notification \
    -c "SYSTEM_NOTIFICATION" \
    -i $ICON \
    -t 2000 \
    "Brightness ${percentage}%" \
    "${message}"
}

case $COMMAND in

  "up")
    brightnessctl s +5%
    show_notification
    ;;

  "down")
    brightnessctl s 5%-
    show_notification
    ;;

  *)
    brightnessctl g
    ;;

esac
