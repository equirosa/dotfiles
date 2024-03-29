{
  programs.kitty = {
    enable = true;
    font = {
      name = "monospace";
      size = 12;
    };
    keybindings = {
      "ctrl+shift+t" = "new_tab_with_cwd";
    };
    settings = {
      background_opacity = "0.8";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
    };
    theme = "Catppuccin-Mocha";
  };
}
