{ config, pkgs, ... }: {
  imports = [ ./xserver.nix ];
  environment.systemPackages = with pkgs; [ xorg.xinit ];
  services.xserver = {
    displayManager.startx.enable = true;
  windowManager = {
    bspwm = {
      enable = true;
      package = pkgs.bspwm;
      configFile = /home/eduardo/.config/bspwm/bspwmrc;
      sxhkd = {
        configFile = /home/eduardo/.config/sxhkd/sxhkdrc;
      };
    };
  };
  };
}
