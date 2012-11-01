#!/bin/sh
[ -z `pidof mpd` ] && sudo rc.d start mpd
urxvtd &
redshift &
[[ -a /etc/X11/xinit/xinitrc ]] && . /etc/X11/xinit/xinitrc
