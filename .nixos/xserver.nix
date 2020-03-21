{ config, pkgs, ... }: {
  imports = [ ./picom.nix ];
  environment = {
    sessionVariables = {
      LOCKSCREEN = "betterlockscreen -l";
    };
    systemPackages = with pkgs; [
     dmenu
     sxhkd
     xclip
      xdotool
      betterlockscreen
    ];
  };
  services = {
    unclutter = {
      enable = true;
    };
    xserver = {
      enable = true;
      layout = "us,latam";
      xkbOptions = "grp:win_space_toggle,ctrl:nocaps";
      libinput.enable = true;
    };
  };
  home-manager.users.eduardo = { pkgs, ... }: {
    services.sxhkd = {
      enable = true;
      keybindings = {
        "super + Return" = "$TERMINAL & disown";
        "super + d" = "dmenu_run";
        "super + e" = "$TERMINAL -e $MAIL";
        "super + r" = "$TERMINAL -e $FILE";
        "super + w" = "$BROWSER";
        "super + x" = "$LOCKSCREEN";
        "super + shift + p" = "emacsclient -p";
        "super + q" =
          ''xdotool windowkill "$(xdotool getactivewindow)"'';
      };
    };
  };
}
