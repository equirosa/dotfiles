{ config, pkgs, ... }: {
  imports = [ ./misc/32bit.nix ];
  users.users.eduardo.packages = [ pkgs.steam ];
}
