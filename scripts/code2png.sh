output_file="$(mktemp --suffix ".png")"
echo "$output_file"
silicon --tab-width 2 "$1" --output "$output_file"
