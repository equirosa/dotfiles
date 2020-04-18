#/bin/sh

# Autostarts
udiskie&
[ "$(tty)" = "/dev/tty1" ] && exec sway
[ "$(tty)" = "/dev/tty2" ] && startx
