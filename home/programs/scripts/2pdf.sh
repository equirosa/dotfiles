[ $# -eq 0 ] && notify "No arguments provided. Exitting..." && exit 1

file="$(realpath "''${1}")"
ext=${file##*.}

case "$ext" in
  odt | docx ) libreoffice --headless --convert-to pdf "$file" ;;
  * ) printf "I can't handle that format yet!\n" ;;
esac
