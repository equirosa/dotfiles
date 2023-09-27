[ $# -eq 0 ] && notify-send "No arguments provided. Exitting..." && exit 1
for arg in "$@"; do
  case "${arg}" in
    magnet* | *.torrent )
      setsid transmission-remote -a "${arg}" && notify-send -u low "Torrent Added! ✅"
      ;;
    *.org ) setsid emacsclient --create-frame "${arg}" ;;
    *.png | *.jpg | *.jpeg | *.webp ) setsid imv "${arg}" ;;
    *.pdf ) zathura "$arg" ;;
    http* ) firefox -P default "${arg}" ;;
    * ) setsid xdg-open "${arg}" ;;
  esac
done
