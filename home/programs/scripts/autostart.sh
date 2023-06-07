day=$(date +%u)

if [ "$day" -le 5 ]; then
	rem-lap
fi
element-desktop
firefox -p default
