{ config, pkgs, ... }: {
  imports =
    [ ../window-managers/xorg/awesome.nix ../syncthing.nix ../eduardo.nix ];
  networking = { hostName = "snowfort"; };
}
