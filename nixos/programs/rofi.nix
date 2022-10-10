{ config, pkgs, ... }: {
  home-manager.users.kiri = {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      cycle = true;
      plugins = [ pkgs.rofi-emoji ];
      theme = "gruvbox-dark";
      extraConfig = {
        modi = "drun,run,emoji";
      };
    };
  };
}
