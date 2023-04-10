cp "${1}" "${HOME}/.cache/background_image"

[ -n "${SWAYSOCK}" ] && swaymsg reload
