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

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

while true; do
	bat0=$(cat /sys/class/power_supply/BAT0/capacity)
	bat0Charging=""
	xsetroot -name "B1: $(cat /sys/class/power_supply/BAT1/capacity)% B0: $(cat /sys/class/power_supply/BAT0/capacity)% | CPU: $(sensors | grep CPU | sed s/' '// | awk '{printf $2}') | $(df -h | grep "/dev/sda2" | awk '{printf $4}') $(free -m | awk 'NR==2{printf $3}')MB $(mpstat | awk 'NR==4{printf $4}')% | $(date '+%H:%M %a %d')"
	sleep 2
done &

#feh --bg-fill /home/c3sar/Wallpapers/wallhaven-2eq9vm.png &
#feh --bg-fill /home/c3sar/Wallpapers/cat.png &
feh --bg-fill /home/c3sar/Wallpapers/dark-souls-knight.gif &

picom &
xbindkeys &
exec dwm
