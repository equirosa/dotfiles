{ config, pkgs, ...}: {
  imports = [
    ./global.nix
    ../gaming.nix
    ../nvidia.nix
    ../sway.nix
    ../syncthing.nix
  ];
  networking = { hostName = "snowfort"; };
}
