{ config, pkgs, ... }: {
  imports = [ ./picom.nix ];
  environment = {
    sessionVariables = { LOCK_CMD = "i3lock-fancy -p"; };
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
    redshift.enable = true;
    unclutter = { enable = true; };
    xserver = {
      enable = true;
      layout = "us,latam";
      xkbOptions = "grp:win_space_toggle,ctrl:nocaps";
      libinput = {
        enable = true;
        disableWhileTyping = true;
      };
    };
  };
}
