day=$(date +%u)

if [ "$day" -le 5 ]; then
	setsid rem-lap
fi
setsid element-desktop
setsid firefox -p default
