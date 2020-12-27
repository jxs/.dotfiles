#!/bin/sh
color1=101111
color2=96999b
color3=87051b
swaylock \
    -e \
    -K \
	--screenshots \
	--clock \
	--indicator \
	--indicator-radius 100 \
    --indicator-x-position 1720 \
    --indicator-y-position 920 \
	--effect-blur 7x5 \
	--ring-color $color1 \
    --inside-clear-color $color1 \
    --inside-caps-lock-color $color2 \
    --inside-caps-lock-color $color1 \
    --inside-wrong-color $color3 \
    --ring-clear-color $color1 \
	--key-hl-color $color3 \
    --bs-hl-color $color2 \
	--line-color 00000000 \
	--inside-color 00000088 \
    --text-color $color2 \
    --text-clear-color $color2 \
    --text-caps-lock-color $color2 \
    --text-wrong-color $color2 \
    --text-ver-color $color2 \
    --layout-text-color $color2 \
	--separator-color 00000000 \
    --inside-ver-color $color1 \
    --ring-ver-color $color2 \
    --ring-wrong-color $color1 \
	--grace 2 \
	--fade-in 0.2
