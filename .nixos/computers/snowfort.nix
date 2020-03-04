{ config, pkgs, ...}: {
  imports = [
    ./global.nix
    ../steam.nix
    ../sway.nix
    ../syncthing.nix
  ];
  networking = { hostName = "snowfort"; };
}
