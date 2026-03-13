#!/usr/bin/env bash
if [ "$GTK_THEME" = "Adwaita:dark" ]; then
    export GTK_THEME=Adwaita:light
    export QT_QPA_PLATFORMTHEME=gtk2
else
    export GTK_THEME=Adwaita:dark
    export QT_QPA_PLATFORMTHEME=gtk2
fi

hyprctl reload