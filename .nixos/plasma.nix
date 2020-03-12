{ config, pkgs, ... }: {
  imports = [ ./xserver.nix ];
  environment = {
    systemPackages = with pkgs; [
      ark
    ];
  };
  nixpkgs.config = {
    firefox.enablePlasmaBrowserIntegration = true;
  };
  services.xserver = {
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };
}
