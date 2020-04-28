# This file is used mostly to force XDG Desktop Specification compliance in some programs.
{ config, lib, options, modulesPath }: {
  environment = {
    shellAliases = {
      startx = "startx $XDG_CONFIG_HOME/x11/xinitrc";
      weechat = "weechat -d $XDG_CONFIG_HOME/weechat";
    };
    variables = {
      XDG_CONFIG_HOME = "/home/eduardo/.config";
      XDG_DATA_HOME = "/home/eduardo/.local/share";
      XDG_CACHE_HOME = "/home/eduardo/.cache";
      GTK2_RC_FILES = "$XDG_CONFIG_HOME/gtk-2.0/gtkrc";
      IDEA_PROPERTIES = "$XDG_CONFIG_HOME/intellij-idea/idea.properties";
      IDEA_VM_OPTIONS = "$XDG_CONFIG_HOME/intellij-idea/idea64.vmoptions";
      LESSHISTFILE = "-"; # Disable less history file
      UNISON = "$XDG_DATA_HOME/unison";
      WEECHAT_HOME = "$XDG_CONFIG_HOME/weechat";
      XCOMPOSEFILE = "$XDG_CONFIG_HOME/X11/xcompose";
      XCOMPOSECACHE = "$XDG_CACHE_HOME/X11/xcompose";
      ZDOTDIR = "$XDG_CONFIG_HOME/zsh";
    };
  };
}
