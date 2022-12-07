OUTPUT_FILE="$(mktemp --sufix ".png")"

silicon --tab-width 2 "${1}" --output "${OUTPUT_FILE}"
