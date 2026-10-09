#!/bin/sh

export PATH="$HOME/.local/bin:$PATH"

export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=dwm
export XDG_SESSION_DESKTOP=dwm

export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx

dbus-update-activation-environment --systemd \
    DISPLAY XAUTHORITY DBUS_SESSION_BUS_ADDRESS \
    XDG_SESSION_TYPE XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP \
    XMODIFIERS GTK_IM_MODULE QT_IM_MODULE

export GTK_THEME=Adwaita

[[ -f "$HOME/.Xresources" ]] && xrdb -merge "$HOME/.Xresources" 
xsetroot -cursor_name left_ptr

xrandr --output DP-1 --primary --mode 1920x1080 --rate 400 --pos 1920x2160 --output DP-2 --mode 3840x2160 --rate 144 --pos 0x0

xwallpaper --daemon --zoom "$HOME/Pictures/IMG_0545.JPG" &

fcitx5 -d &
picom --config "$HOME/.config/picom/picom.conf" &
slstatus &

(
    sleep 2
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 100%
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
) &

exec "/usr/local/bin/dwm"
