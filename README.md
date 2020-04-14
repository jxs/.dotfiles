# dot files


## X11 trackpad

```conf
# should be in /etc/X11/xorg.conf.d/
Section "InputClass"
        Identifier "touchpad"
        MatchIsTouchpad "on"
        Driver "libinput"
        Option "Tapping" "on"
        Option "TappingDrag" "false"
EndSection
```
