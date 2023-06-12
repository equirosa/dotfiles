day=$(date +%u)

if [ "$day" -le 5 ]; then
	setsid rem-lap
fi

swww init
swww img "${XDG_PICTURES_DIR}/desktop_backgrounds/gifs/city.gif"
setsid transmission-daemon
setsid element-desktop
setsid firefox -p default
