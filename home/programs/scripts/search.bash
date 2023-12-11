engines=(
	"github.com/search?q="
	"flathub.org/apps/search?q="
	"nixos.wiki/index.php?search="
	"search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query="
	"search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query="
	"protondb.com/search?q="
	"youtube.com/results?search_query="
)

selected_url="$(echo -e "${urls[@]}" | rofi -dmenu -p 'Choose URL:')"

input="$(rofi -dmenu -p 'Enter Text:')"

if [ -n "${selected_url}" ]; then
	# Open the selected URL in the default web browser
	xdg-open "${selected_url}${input}"
else
	# User canceled, exit script
	exit 1
fi
