{ pkgs
, config
, lib
, ...
}:
let
  inherit (lib) optionalString;
  inherit (builtins) attrValues;
  abbreviations = import ./abbreviations.nix;
  aliases = import ./aliases.nix { inherit pkgs; };
in
{
  users.users.kiri.shell = pkgs.fish;
  home-manager.users.kiri = { config, ... }: {
    home.packages = attrValues { inherit (pkgs) jq; };
    programs = {
      fish = {
        enable = true;
        shellAbbrs = abbreviations;
        loginShellInit = '''' + optionalString config.wayland.windowManager.sway.enable ''
          ${builtins.readFile ./autolaunch_sway.fish}
        '';
        interactiveShellInit = ''
          ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
        '' + optionalString config.programs.neovim.enable ''
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
