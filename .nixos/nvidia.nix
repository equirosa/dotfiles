{ config, pkgs, ...}: {
  imports = [ ./unfree.nix ];
  services.xserver.videoDrivers = [ "nvidia" ];
}
