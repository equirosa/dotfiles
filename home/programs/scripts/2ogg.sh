[ $# -eq 0 ] && error "No arguments provided. Exitting..." && exit 1
file="$(realpath "${1}")"
extension=${file##*.}
base=''${file%.*}
info="$(mediainfo "${file}")"

case "${info}" in
    *"Opus"* | *"opus"* )
        error "File already optimized"
        exit 1
        ;;
    * )
        if [ "${extension}" = "ogg" ]; then
            bak="${base}.bak.ogg"
            cp "${file}" "${bak}"
        fi
        ffmpeg -i "${bak}" -c:a libopus -b:a 128k "${file}"
        ;;
esac

