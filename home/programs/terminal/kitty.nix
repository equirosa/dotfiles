{ colors, ... }: {
  programs.kitty = {
    enable = true;
    font = {
      name = "monospace";
      size = 14;
    };
    keybindings = { };
    settings = {
      background_opacity = "${colors.opacity}";
      tab_bar_min_tabs = 2;
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
    };
    theme = "Gruvbox Dark Hard";
  };
}
