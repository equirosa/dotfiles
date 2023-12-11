engines=(
	"github.com/search?q="
	"flathub.org/apps/search?q="
	"nixos.wiki/index.php?search="
	"search.nixos.org/packages?channel=unstable&query="
	"search.nixos.org/options?channel=unstable&query="
	"protondb.com/search?q="
	"youtube.com/results?search_query="
)

formatted_engines="$(printf "%s\n" "${engines[@]}")"

selected_url="$(echo "${formatted_engines[@]}" | rofi -dmenu -p 'Choose URL:')"

input="$(rofi -dmenu -p 'Enter Text:')"

if [ -n "${selected_url}" ]; then
	# Open the selected URL in the default web browser
	firefox -P default "${selected_url}${input}"
else
	# User canceled, exit script
	exit 1
fi
