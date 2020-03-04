{ config, pkgs, ...}: {
  imports = [
    ./global.nix
    ../sway.nix
    ../syncthing.nix
  ];
  networking = { hostName = "snowfort"; };
}
