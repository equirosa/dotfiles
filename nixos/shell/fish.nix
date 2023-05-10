{ pkgs
, lib
, ...
}:
let
  inherit (lib) getExe optionalString;
  abbreviations = import ./abbreviations.nix;
in
{
  users.users.kiri.shell = pkgs.fish;
  programs.fish = { enable = true; useBabelfish = true; };
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
          '';
          interactiveShellInit = ''
            ${getExe pkgs.nix-your-shell} fish | source
            ${optionalString neovim.enable "set -gx EDITOR nvim"}
          '';
          plugins = with pkgs.fishPlugins; [
            {name = "done"; src = done;}
          ];
        };
      };
    };
}
