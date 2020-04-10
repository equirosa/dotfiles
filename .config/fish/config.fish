# Sourcing
[ -f "$HOME/.config/aliasrc" ] && . "$HOME/.config/aliasrc"

#XDG
set XDG_CONFIG_HOME "/home/eduardo/.config"
set XDG_CACHE_HOME "/home/eduardo/.cache"
set XDG_DATA_HOME "/home/eduardo/.local/share"

# Cleanup
# Environmental Variables
set GTK2_RC_FILES "$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
set IDEA_PROPERTIES "$XDG_CONFIG_HOME/intellij-idea/idea.properties"
set IDEA_VM_OPTIONS "$XDG_CONFIG_HOME/intellij-idea/idea64.vmoptions"
set LESSHISTFILE - # Disable less history file
set UNISON "$XDG_DATA_HOME/unison"
set XCOMPOSEFILE "$XDG_CONFIG_HOME/X11/xcompose"
set XCOMPOSECACHE "$XDG_CACHE_HOME/X11/xcompose"
set ZDOTDIR "$XDG_CONFIG_HOME/zsh"

# Aliases
alias nvidia-settings="nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings"
alias startx="startx '$XDG_CONFIG_HOME/x11/xinitrc'"

# Env Variables
set PATH "$XDG_DATA_HOME/scripts:PATH"
set BROWSER "qutebrowser"
set EDITOR "vim"
set FILE "lf"
set IMG "imv"
set MAIL "aerc"
set READER "zathura"
set TERMINAL "kitty"
set LOCK_CMD "i3lock-fancy -p"

