[ $# -eq 0 ] && notify-send "No arguments provided. Exitting..." && exit 1
arg=$1
add_torrent() {
	setsid transmission-remote -a "$1" && notify-send -u low "Torrent Added! ✅"
}

handle_mime() {
	case $1 in
		application/pdf) setsid zathura "$arg" ;;
		image/jxl) firefox -P default "$arg" ;;
		image/*) setsid imv "$arg" ;;
		video/*) setsid mpv "$arg" ;;
		*) setsid xdg-open "$arg" ;;
	esac
}

case "$arg" in
	magnet* | *.torrent) add_torrent "$arg" ;;
	*.org) setsid emacsclient --create-frame "$arg" ;;
	http*) firefox -P default "$arg" ;;
	*)
		mimetype=$(file --mime-type --brief "$arg")
		handle_mime "$mimetype"
		;;
esac

exit 0
