engines=(
	"github.com/search?q="
	"flathub.org/apps/search?q="
	"nixos.wiki/index.php?search="
	"search.nixos.org/packages?channel=unstable&query="
	"search.nixos.org/options?channel=unstable&query="
	"protondb.com/search?q="
	"youtube.com/results?search_query="
)

selected_url="$(printf "%s\n" "${engines[@]}" | rofi -dmenu -p 'Choose URL:')"

if [ -z "${selected_url}" ]; then
	# User canceled, exit script
	exit 1
fi

input="$(rofi -dmenu -p 'Enter Text:')"

if [ -z "${input}" ]; then
	# User canceled, exit script
	exit 1
fi

# Open the selected URL in the default web browser
firefox -P default "${selected_url}${input}"
