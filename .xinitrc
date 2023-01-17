#!/bin/bash

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

while true; do
	xsetroot -name "$(df -h | grep "/dev/sda3" | awk '{printf $4}') $(free -m | awk 'NR==2{printf $3}')MB $(date '+%H:%M %a %d')"
	sleep 2
done &

exec dwm
