{ config
, pkgs
, ...
}:
let
  colors = import ../colors.nix;
in
{
  home-manager.users.kiri = {
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
  };
}
