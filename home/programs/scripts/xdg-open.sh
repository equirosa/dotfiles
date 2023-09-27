[ $# -eq 0 ] && notify-send "No arguments provided. Exitting..." && exit 1
arg=$1
add_torrent() {
    setsid transmission-remote -a "$1" && notify-send -u low "Torrent Added! ✅"
}

case "${arg}" in
    magnet* | *.torrent ) add_torrent "$arg" ;;
    *.org ) setsid emacsclient --create-frame "${arg}" ;;
    *.png | *.jpg | *.jpeg | *.webp ) setsid imv "${arg}" ;;
    *.pdf ) zathura "$arg" ;;
    http* ) firefox -P default "${arg}" ;;
    * ) setsid xdg-open "${arg}" ;;
esac
