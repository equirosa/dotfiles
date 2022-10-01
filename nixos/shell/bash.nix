{ pkgs
, config
, lib
, ...
}:
let
  abbreviations = import ./abbreviations.nix;
  aliases = import ./aliases.nix { inherit pkgs; };
in
{
  home-manager.users.kiri = {
    programs = {
      bash = {
        enable = true;
        shellAliases = builtins.removeAttrs (lib.trivial.mergeAttrs aliases abbreviations) [ "l" "ll" ];
      };
    };
  };
}
