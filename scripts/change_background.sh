cp --reflink=always -i "${1}" "${HOME}/.cache/background_image"

[ -z "${SWAYSOCK}" ] || swaymsg reload
