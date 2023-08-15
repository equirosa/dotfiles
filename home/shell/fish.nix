{ pkgs
, lib
, ...
}:
let
  inherit (lib) getExe;
in
{
  home.packages = [ pkgs.jq ];
  programs = {
    fish = {
      enable = true;
      shellAbbrs = import ./abbreviations.nix;
      interactiveShellInit = ''
        set -gx EDITOR nvim
        bind \cx 'exec $SHELL'
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
