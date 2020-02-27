#!/usr/bin/env sh

# Sourcing
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Environment Variables
export PATH="$HOME/.local/share/scripts:$PATH"
export BROWSER="firefox"
export EDITOR="nvim"
export FILE="lf"
export IMAGE_VIEWER="imv"
export MAIL="aerc"
export READER="zathura"
export TERMINAL="kitty"

## Less variables, mostly color
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"

## Things sourced by some programs
### password-store
export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"
### lf's icons
export LF_ICONS="di=:fi=:ln=:or=:ex=:*.c=:*.cc=:*.cpp=ﭱ:*.js=:*.vimrc=:*.vim=:*.nix=:*.css=:*.pdf=:*.html=:*.rs=:*.rlib=:*.7z=:*.git=:*.webm=:*.mp4=:*.flac=:*.deb=:*.rpm=:*.py=:*.md=:*.json=:*.mkv=:*.go="
### zsh's dotfile directory
export ZDOTDIR="$HOME/.config/zsh"

# Autolaunch
[ "$(tty)" = "/dev/tty1" ] && exec sway
if [ -e /home/eduardo/.nix-profile/etc/profile.d/nix.sh ]; then . /home/eduardo/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
