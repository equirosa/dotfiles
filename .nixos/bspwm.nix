{ config, pkgs, ... }: {
  imports = [ ./xserver.nix ];
  services.xserver.windowManager = {
    bspwm = {
      enable = true;
      package = pkgs.bspwm;
      configFile = /home/eduardo/.config/bspwm/bspwmrc;
      sxhkd = {
        configFile = /home/eduardo/.config/sxhkd/sxhkdrc;
      };
    };
  };
}
