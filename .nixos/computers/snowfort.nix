{ config, pkgs, ...}: {
  imports = [
    ./global.nix
    ../gaming.nix
    ../nvidia.nix
    ../syncthing.nix
  ];
  networking = { hostName = "snowfort"; };
}
