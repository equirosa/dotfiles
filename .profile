#/bin/sh
. ~/.nix-profile/etc/profile.d/hm-session-vars.sh

# Environment Variables
export PATH="/home/eduardo/.local/share/scripts:$PATH"


# Autostarts
pgrep -x syncthing >>/dev/null || syncthing & disown
pgrep -x udiskie >>/dev/null || udiskie & disown
pgrep -x transmission-da >>/dev/null || transmission-daemon & disown
[ "$(tty)" = "/dev/tty1" ] && exec sway
[ "$(tty)" = "/dev/tty2" ] && startx
