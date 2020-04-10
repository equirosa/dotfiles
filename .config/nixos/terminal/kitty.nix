{ config, pkgs, ... }: {
  environment.shellAliases = {
    icat = "kitty +kitten icat";
  };
  home-manager.users.eduardo = { pkgs, ... }: {
    programs.kitty = {
      enable = true;
      font.name = "Fira Code Nerd Font";
      settings = {
        # Copy
        strip_trailing_spaces = "smart";

        # Color
        background = "#282a36";
        foreground = "#f8f8f2";
        selection_foreground = "#44475a";
        selection_background = "#f8f8f2";
        url_color  = "#ffb86c";
        color0   = "#21222c";
        color8   = "#6272a4";
        color1   = "#ff5555";
        color9   = "#ff6e6e";
        color2   = "#50fa7b";
        color10  = "#69ff94";
        color3   = "#f1fa8c";
        color11  = "#ffffa5";
        color4   = "#bd93f9";
        color12  = "#d6acff";
        color5   = "#ff79c6";
        color13  = "#ff92df";
        color6   = "#8be9fd";
        color14  = "#a4ffff";
        color7   = "#f8f8f2";
        color15  = "#ffffff";
        cursor  = "#f8f8f2";
        cursor_text_color = "background";
        active_tab_foreground    = "#44475a";
        active_tab_background    = "#f8f8f2";
        inactive_tab_foreground  = "#282a36";
        inactive_tab_background  = "#6272a4";
        background_opacity = "0.75";
        dim_opacity = "0.75";

        # Cursor
        cursor_stop_blinking_after = "0.2";

        # Tab
        tab_bar_style = "fade";
        tab_separator = "~~";
        tab_fade = "0.2 0.45 0.6 0.9";
        # Window
        window_border_width = "1";
        window_margin_width = "1";
        window_padding_width = "5";
        active_border_color = "#e2b0ff";
        inactive_text_alpha = "0.8";
      };
    };
  };
}
