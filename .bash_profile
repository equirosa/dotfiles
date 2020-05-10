#/bin/sh

# Autostarts
udiskie&
[ "$(tty)" = "/dev/tty1" ] && exec sway
