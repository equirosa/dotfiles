{ config, pkgs, ... }: {
  imports = [ ../global.nix ];
  networking = { hostName = "snowfort"; };
}
