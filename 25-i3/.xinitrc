xrandr --setprovideroutputsource LVDS1
xrandr --auto
autorandr
xrdb ~/.Xresources
xmodmap ~/.Xmodmap
unclutter &
setxkbmap -option caps:escape,compose:ralt us
case $WM in
    i3)
        exec i3
        ;;
    dwm)
        exec dwm
        ;;
    *)
        exec i3
        ;;
esac
