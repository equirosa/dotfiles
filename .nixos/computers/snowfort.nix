{ config, pkgs, ...}: {
  imports = [
    ./global.nix
    ../gaming.nix
    ../sway.nix
    ../syncthing.nix
  ];
  networking = { hostName = "snowfort"; };
}
