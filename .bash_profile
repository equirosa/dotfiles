#/bin/sh
[ -f "$HOME/.config/aliasrc" ] && . "$HOME/.config/aliasrc"

# Autostarts
udiskie&
[ "$(tty)" = "/dev/tty1" ] && exec sway
