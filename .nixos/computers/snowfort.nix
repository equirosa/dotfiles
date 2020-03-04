{ config, pkgs, ...}: {
  imports = [
    ./global.nix
    ../sway.nix
  ];
  networking = { hostName = "snowfort"; };
}
