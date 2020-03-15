{ config, pkgs, ... }: {
  imports = [ ./picom.nix ];
  environment.systemPackages = with pkgs; [
    dmenu
    xclip
    xdotool
  ];
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
      };
    };
  };
}
