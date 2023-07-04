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
        ${getExe pkgs.nix-your-shell} fish | source
        set -gx EDITOR nvim
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
