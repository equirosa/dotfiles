{ config, pkgs, ... }: {
  imports = [ ./xserver.nix ];
  services.xserver = {
    displayManager.startx.enable = true;
    windowManager.awesome.enable = true;
  };
}
