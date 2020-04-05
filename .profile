#!/usr/bin/env sh

# Sourcing
. "/home/eduardo/.nix-profile/etc/profile.d/hm-session-vars.sh"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Environment Variables
export BROWSER="next"
export EDITOR="vim"
export FILE="lf"
export IMG="imv"
export MAIL="aerc"
export READER="zathura"
export TERMINAL="kitty"
export LOCKSCREEN="betterlockscreen -l"

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
### lf's icons
export LF_ICONS="di=:fi=:ln=:or=:ex=:*.c=:*.cc=:*.cpp=ﭱ:*.js=:*.vimrc=:*.vim=:*.nix=:*.css=:*.pdf=:*.html=:*.rs=:*.rlib=:*.7z=:*.git=:*.webm=:*.mp4=:*.flac=:*.deb=:*.rpm=:*.py=:*.md=:*.json=:*.mkv=:*.go=:.git="

# Cleanup
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export IDEA_PROPERTIES="$XDG_CONFIG_HOME/intellij-idea/idea.properties"
export IDEA_VM_OPTIONS="$XDG_CONFIG_HOME/intellij-idea/idea64.vmoptions"
export LESSKEY="$XDG_CACHE_HOME/less"
export LESSHISTFILE=- # Disable less history file
export UNISON="$XDG_DATA_HOME/unison"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Autolaunch
which sway >/dev/null && [ "$(tty)" = "/dev/tty1" ] && exec sway

case "$0" in
	*zsh | *bash) eval "$(starship init $0)";;
esac
