{ pkgs
, config
, lib
, ...
}:
let
  inherit (lib) getExe optionalString;
  inherit (builtins) attrValues readFile;
  abbreviations = import ./abbreviations.nix;
in
{
  users.users.kiri.shell = pkgs.fish;
  home-manager.users.kiri = { config, ... }:
    let
      inherit (config.programs) neovim;
      inherit (config.wayland.windowManager) sway;
    in
    {
      home.packages = [ pkgs.jq ];
      programs = {
        fish = {
          enable = true;
          shellAbbrs = abbreviations;
          loginShellInit = optionalString sway.enable ''
            ${readFile ./autolaunch_sway.fish}
          '';
          interactiveShellInit = ''
            ${getExe pkgs.any-nix-shell} fish --info-right | source
            ${optionalString neovim.enable "set -gx EDITOR nvim"}
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
