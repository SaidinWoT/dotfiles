#!/bin/sh
[ -z `pidof mpd` ] && sudo mpd
urxvtd &
redshift &
eval $(gpg-agent -- daemon) &
setxkbmap \
    -layout 'us,us' \
    -variant 'altgr-intl,colemak' \
    -option grp:sclk_toggle \
    -option grp_led:caps \
    -option compose:rctrl \
    -option ctrl:nocaps \
    -option terminate:ctrl_alt_bksp \
    -option nbsp:level3n
[[ -a /etc/X11/xinit/xinitrc ]] && . /etc/X11/xinit/xinitrc
xcape -e 'Control_L=Escape;Alt_R=Tab'
#sbcl --load ~/quicklisp/dists/quicklisp/software/clfswm-20121013-git/load.lisp >> ~/clfswm.log
exec awesome
