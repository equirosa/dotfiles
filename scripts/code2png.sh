OUTPUT_FILE="$(mktemp --suffix ".png")"

printf "%s" "${OUTPUT_FILE}\n"

silicon --tab-width 2 "${1}" --output "${OUTPUT_FILE}"
