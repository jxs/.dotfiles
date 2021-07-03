#!/bin/bash
set -e
rectangles=" "

SR=$(xrandr --query | grep ' connected' | grep -o '[0-9][0-9]*x[0-9][0-9]*[^ ]*')
for RES in $SR; do
  SRA=(${RES//[x+]/ })
  CX=$((${SRA[2]} + 35))
  CY=$((${SRA[1]} - 130))
  rectangles+="rectangle $CX,$CY $((CX+365)),$((CY-150)) "
done

TMPBG=/tmp/screen.png
scrot $TMPBG && convert $TMPBG -scale 5.05% -scale 2000% -draw "fill black fill-opacity 0.4 $rectangles" $TMPBG

xset s off dpms 0 10 0
i3lock \
  -i $TMPBG  \
  --time-pos="x+100:h-120" \
  --date-pos="x+130:h-100" \
  --clock \
  --inside-color=00000000 --ring-color=ffffffff --line-uses-inside \
  --keyhl-color=d23c3dff --bshl-color=d23c3dff --separator-color=00000000 \
  --insidever-color=fecf4dff --insidewrong-color=d23c3dff \
  --ringver-color=ffffffff --ringwrong-color=ffffffff --ind-pos="x+290:h-120" \
  --radius=20 --ring-width=3 --verif-text="" --wrong-text="" \
  --verif-color="ffffffff" --time-color="ffffffff" --date-color="ffffffff"

xset s off -dpms

rm $TMPBG
