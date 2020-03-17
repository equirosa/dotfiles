{ config, pkgs, ...}: {
  imports = [
    ./global.nix
    ../gaming.nix
    ../syncthing.nix
    #../bspwm.nix
  ];
  networking = { hostName = "snowfort"; };
}
