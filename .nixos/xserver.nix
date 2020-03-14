{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
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
        "super + Return" = "$TERMINAL";
        "super + e" = "$TERMINAL -e $MAIL";
        "super + r" = "$TERMINAL -e $FILE";
        "super + w" = "$BROWSER";
      };
    };
  };
}
