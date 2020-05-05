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
  --timepos="x+100:h-120" \
  --datepos="x+130:h-100" \
  --clock --datestr "Type password to unlock..." \
  --insidecolor=00000000 --ringcolor=ffffffff --line-uses-inside \
  --keyhlcolor=d23c3dff --bshlcolor=d23c3dff --separatorcolor=00000000 \
  --insidevercolor=fecf4dff --insidewrongcolor=d23c3dff \
  --ringvercolor=ffffffff --ringwrongcolor=ffffffff --indpos="x+290:h-120" \
  --radius=20 --ring-width=3 --veriftext="" --wrongtext="" \
  --verifcolor="ffffffff" --timecolor="ffffffff" --datecolor="ffffffff"

xset s off -dpms

rm $TMPBG
