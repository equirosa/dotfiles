{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe optionalString;
in {
  users.users.kiri.shell = pkgs.fish;
  programs.fish = {
    enable = true;
    useBabelfish = true;
  };
  home-manager.users.kiri = {config, ...}: let
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
  };
}
