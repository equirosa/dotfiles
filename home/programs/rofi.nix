{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    cycle = true;
    plugins = [pkgs.rofi-emoji];
    theme = "gruvbox-dark";
    extraConfig = {
      modi = "drun,run,emoji";
    };
  };
}
