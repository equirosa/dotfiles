{ config, pkgs, ...}: {
  imports = [
    ./global.nix
    ../sway.nix
  ];
}
