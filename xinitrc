#!/bin

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

if [ -d /etc/X11/xinit/xinitrc.d ]; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

while true; do
	bat0=$(cat /sys/class/power_supply/BAT0/capacity)
	bat1=$(cat /sys/class/power_supply/BAT1/capacity)
	xsetroot -name " $(echo $(ifconfig | grep wlan0* -A1 | grep inet | awk '{print $2}')) | B1: $bat1% B0: $bat0% | CPU: $(sensors | grep CPU | sed s/' '// | awk '{printf $2}') | $(df -h | grep '/dev/sda2' | awk '{printf $4}') $(free -m | awk 'NR==2{printf $3}')MB $(mpstat | awk 'NR==4{printf $4}')% | $(date '+%H:%M %a %d')"
	sleep 2
	#if [ $bat0 -lt 80  ] && [ $bat1 -lt 80 ]; then
	#	notify-send -t 3000 "Low battery!" "Battery is under 20%" --icon=dialog-information
	#fi
done &

feh --bg-fill /home/c3sar/Wallpapers/b1.png &

picom &
xbindkeys &
exec dwm
