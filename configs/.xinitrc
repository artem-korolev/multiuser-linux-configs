#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

#if [ -d /etc/X11/xinit/xinitrc.d ] ; then
# for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
#  [ -x "$f" ] && . "$f"
# done
# unset f
#fi

#xclock -geometry 50x50-1+1 &
#xscreensaver -no-splash &
#xclock -d -twentyfour -update 1 &

# Skippy-xd
# skippy-xd-toggle

# Conky - system monitor
#sh "$HOME/.conky/conky-startup.sh"
#killall conky
#cd "$HOME/.conky/Green Apple Desktop"
#conky -u 5 -c "$HOME/.conky/Green Apple Desktop/Gotham" &
#cd "$HOME/.conky/Green Apple Desktop"
#conky -u 5 -c "$HOME/.conky/Green Apple Desktop/conky_seamod" &

#gis-weather &
#konsole &
# guake &
if [[ -f "$HOME/.xinitrc_local" ]] ;
then
	source "$HOME/.xinitrc_local"
fi
exec /opt/openbox-3.6.1/bin/openbox
#exec kwin_x11
#exec sway

#export LD_LIBRARY_PATH="/opt/xcb-util-xrm/lib:/opt/yajl/lib:/opt/libev/lib:$LD_LIBRARY_PATH"
#export PATH="/opt/i3-gaps/bin:$PATH"
#exec /opt/i3-gaps/bin/i3
