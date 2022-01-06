{ pkgs, ... }:
let
  abbreviations = (import ./abbreviations.nix);
  aliases = (import ./aliases.nix);
in
{
  users.users.kiri.shell = pkgs.fish;
  home-manager.users.kiri = {
    programs = {
      fish = {
        enable = true;
        shellAbbrs = abbreviations;
        #shellAliases = aliases;
      };
    };
  };
}
