export QT_QPA_PLATFORMTHEME=qt5ct
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_FONT_DPI=110 vym

eval $(ssh-agent)

exec  i3
