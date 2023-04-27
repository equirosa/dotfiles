{ pkgs
, config
, lib
, ...
}:
let
  inherit (lib) getExe optionalString fileContents;
  inherit (builtins) attrValues;
  abbreviations = import ./abbreviations.nix;
in
{
  users.users.kiri.shell = pkgs.fish;
  programs.fish={enable = true;useBabelfish= true;};
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
            ${fileContents ./autolaunch_sway.fish}
          '';
          interactiveShellInit = ''
            ${getExe pkgs.nix-your-shell} fish | source
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
