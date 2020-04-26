{ config, pkgs, ... }: {
  imports =
    [ ../eduardo.nix ];
  networking = { hostName = "snowfort"; };
}
