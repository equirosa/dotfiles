# -*- mode: sh -*-

[ -f "$HOME/.profile" ] && source "$HOME/.profile"
[ -f "$HOME/.config/aliasrc" ] && . "$HOME/.config/aliasrc"

# Commands that should be applied only for interactive shells.
if [[ $- == *i* ]]; then
	HISTCONTROL=erasedups
	HISTFILE="$HOME/.cache/bash_history"
	HISTFILESIZE=100000
	HISTIGNORE=ls:cd:exit
	HISTSIZE=10000

	shopt -s histappend
	shopt -s checkwinsize
	shopt -s extglob
	shopt -s globstar
	shopt -s checkjobs

	eval "$(keychain --eval --quiet --agents ssh --inherit local-once sourcehut github gitlab codeberg vultr-debian)"
	eval "$(starship init bash)"

fi
