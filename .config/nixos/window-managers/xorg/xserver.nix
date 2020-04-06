{ config, pkgs, ... }: {
  imports = [ ./picom.nix ];
  environment = {
    sessionVariables = {
      LOCKSCREEN = "betterlockscreen -l";
    };
    systemPackages = with pkgs; [
      betterlockscreen
      dmenu
      i3lock-fancy
      maim
      sxhkd
      xclip
      xdotool
      xorg.xkill
    ];
  };
  services = {
    unclutter = { enable = true; };
    xserver = {
      enable = true;
      layout = "us,latam";
      xkbOptions = "grp:win_space_toggle,ctrl:nocaps";
      libinput = {
        enable = true;
        disableWhileTyping = true;
        naturalScrolling = true;
      };
    };
  };
}
