#/bin/sh

# Autostarts
udiskie & disown
transmission-daemon & disown
[ "$(tty)" = "/dev/tty1" ] && exec sway
