find "${HOME}/.config/emacs" -name "*.el" -exec emacs --quick --batch -f batch-byte-compile {} \;
