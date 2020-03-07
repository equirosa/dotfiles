#ZSH config
#### Source some files ####
[ -f ./.zprofile ] && source ./.zprofile

zstyle ':completion:*' menu select

# Launch starship
eval "$(starship init zsh)"
