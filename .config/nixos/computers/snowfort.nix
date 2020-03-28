{ config, pkgs, ... }: {
  imports = [ ../syncthing.nix ../eduardo.nix ];
  networking = { hostName = "snowfort"; };
}
