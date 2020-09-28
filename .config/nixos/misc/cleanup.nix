# This file is used mostly to force XDG Desktop Specification compliance in some programs.
{ config, lib, options, modulesPath }: {
  environment = {
    shellAliases = {
      startx = "startx $XDG_CONFIG_HOME/x11/xinitrc";
      weechat = "weechat -d $XDG_CONFIG_HOME/weechat";
    };
    variables = {
      # General XDG variables
      XDG_CONFIG_HOME = "/home/eduardo/.config";
      XDG_DATA_HOME = "/home/eduardo/.local/share";
      XDG_CACHE_HOME = "/home/eduardo/.cache";
      # Forcing compliance
      HISTFILE = "/home/eduardo/.cache/history";
      GTK2_RC_FILES = "/home/eduardo/.config/gtk-2.0/gtkrc";
      IDEA_PROPERTIES = "/home/eduardo/.config/intellij-idea/idea.properties";
      IDEA_VM_OPTIONS = "/home/eduardo/.config/intellij-idea/idea64.vmoptions";
      LESSHISTFILE = "-"; # Disable less history file
      PASSWORD_STORE_DIR = "/home/eduardo/.local/share/password-store";
      UNISON = "/home/eduardo/.local/share/unison";
      WEECHAT_HOME = "/home/eduardo/.config/weechat";
      XCOMPOSEFILE = "/home/eduardo/.config/X11/xcompose";
      XCOMPOSECACHE = "/home/eduardo/.cache/X11/xcompose";
      ZDOTDIR = "/home/eduardo/.config/zsh";
    };
  };
}
