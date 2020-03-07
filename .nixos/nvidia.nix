{ config, pkgs, ...}: {
  imports = [ ./misc/unfree.nix ];
  services.xserver.videoDrivers = [ "nvidia" ];
}
