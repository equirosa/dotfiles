{
  pkgs,
  config,
  lib,
  ...
}: let
  abbreviations = import ./abbreviations.nix;
  aliases = import ./aliases.nix {inherit pkgs;};
in {
  users.users.kiri.shell = pkgs.fish;
  home-manager.users.kiri = {
    programs = {
      fish = {
        enable = true;
        shellAliases = aliases;
        shellAbbrs = abbreviations;
        interactiveShellInit = ''
          ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
          set -gx EDITOR nvim
        '';
        plugins = [
          {
            name = "done";
            src = pkgs.fetchFromGitHub {
              owner = "franciscolourenco";
              repo = "done";
              rev = "1.16.5";
              sha256 = "sha256-E0wveeDw1VzEH2kzn63q9hy1xkccfxQHBV2gVpu2IdQ=";
            };
          }
        ];
      };
    };
  };
}
