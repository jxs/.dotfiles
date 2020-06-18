export QT_QPA_PLATFORMTHEME=qt5ct
export QT_AUTO_SCREEN_SCALE_FACTOR=1.2
export QT_FONT_DPI=130 vym
export GDK_DPI_SCALE=1.8
export GDK_DPI_SCALE=1.5

eval $(ssh-agent)

exec  i3
