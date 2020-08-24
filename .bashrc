# -*- mode: sh -*-
# Sourcing
. "$HOME/.config/aliasrc"

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

	eval "keychain --inherit any --eval -q\
		sourcehut\
		github\
		gitlab\
		codeberg\
		vultr-debian\
		B77F36C3F12720B4" >>/dev/null
	eval "$(starship init bash)"
	eval "$(direnv hook bash)"

fi
