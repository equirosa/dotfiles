{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) getExe optionalString;
  inherit (config.programs) neovim;
in {
  home.packages = [pkgs.jq];
  programs = {
    fish = {
      enable = true;
      shellAbbrs = import ./abbreviations.nix;
      interactiveShellInit = ''
        ${getExe pkgs.nix-your-shell} fish | source
        ${optionalString neovim.enable "set -gx EDITOR nvim"}
      '';
      plugins = with pkgs.fishPlugins; [
        {
          name = "done";
          src = done;
        }
      ];
    };
  };
}
