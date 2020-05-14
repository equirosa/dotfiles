#/bin/sh

# Autostarts
udiskie & disown
[ "$(tty)" = "/dev/tty1" ] && exec sway
