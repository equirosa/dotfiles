{ config
, pkgs
, ...
}:
{
  home-manager.users.kiri = {
    programs.kitty = {
      enable = true;
      font = {
        name = "monospace";
        size = 14;
      };
      keybindings = { };
      settings = { background_opacity = "0.9"; };
      theme = "Gruvbox Dark Hard";
    };
  };
}
