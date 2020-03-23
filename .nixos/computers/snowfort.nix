{ config, pkgs, ...}: {
  imports = [
    ./global.nix
    ../syncthing.nix
    #../bspwm.nix
  ];
  networking = { hostName = "snowfort"; };
}
