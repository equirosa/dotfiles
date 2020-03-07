{ config, pkgs, ... }: {
  imports = [ ./xserver.nix ];
  nixpkgs.config = {
    firefox.enablePlasmaBrowserIntegration = true;
  };
  services.xserver = {
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };
}
