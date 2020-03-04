{ config, pkgs, ... }: {
  imports = [
    ./misc/32bit.nix
    ./misc/unfree.nix
  ];
  users.users.eduardo.packages = [ pkgs.steam ];
}
