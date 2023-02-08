OUTPUT_FILE="$(mktemp --suffix ".png")"

echo "${OUTPUT_FILE}"

silicon --tab-width 2 "${1}" --output "${OUTPUT_FILE}"
