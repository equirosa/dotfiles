{ config
, pkgs
, ...
}:
let
  colors = import ../colors.nix;
in
{
  programs.kitty = {
    enable = true;
    font = {
      name = "monospace";
      size = 14;
    };
    keybindings = { };
    settings = { background_opacity = "${colors.opacity}"; };
    theme = "Gruvbox Dark Hard";
  };
}
