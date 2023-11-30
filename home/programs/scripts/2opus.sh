#!/bin/sh
[ $# -eq 0 ] && error "No arguments provided. Exitting..." && exit 1
file="$(realpath "${1}")"
extension=${file##*.}
base=''${file%.*}
info="$(mediainfo "${file}")"

case "${info}" in
*"Opus"* | *"opus"*)
  if [ "${extension}" = "opus" ]; then
    error "File already optimized"
    exit 1
  else
    echo "Wrong file extension, correcting..."
    rename .ogg .opus "${file}"
  fi
  ;;
*)
  temp_out="$(mktemp --suffix=.opus)"
  ffmpeg -i "${file}" -c:a libopus -b:a 128k -y "${temp_out}"
  mv "${temp_out}" "${base}.opus"
  ;;
esac
