{ pkgs, ... }:
let
  resetBrowser = ''set browser "xdg-open"'';
  macroList = [
    {
      key = "m";
      action = "mpv --keep-open=no --title=newsboat";
    }
    {
      key = "u";
      action = "umpv";
    }
    {
      key = "b";
      action = "firefox -p default";
    }
    {
      key = "d";
      action = "watchlist";
    }
  ];
  controlsList = [
    {
      key = "j";
      action = "down";
    }
    {
      key = "k";
      action = "up";
    }
    {
      key = "j";
      action = "next articlelist";
    }
    {
      key = "k";
      action = "prev articlelist";
    }
    {
      key = "G";
      action = "end";
    }
    {
      key = "g";
      action = "home";
    }
    {
      key = "a";
      action = "toggle-article-read";
    }
    {
      key = "l";
      action = "open";
    }
    {
      key = "h";
      action = "quit";
    }
    {
      key = "u";
      action = "show-urls";
    }
    {
      key = "T";
      action = "toggle-show-read-feeds";
    }
    {
      key = "O";
      action = "open-in-browser-and-mark-read";
    }
  ];
  articleColors = [
    {
      pattern = "(^Feed:.*|^Title:.*|^Author:.*)";
      color = "cyan default bold";
    }
    {
      pattern = "(^Link:.*|^Date:.*)";
      color = "default default";
    }
    {
      pattern = "https?://[^ ]+";
      color = "green default";
    }
    {
      pattern = "^(Title):.*$";
      color = "blue default";
    }
    {
      pattern = "\\[[0-9][0-9]*\\]";
      color = "magenta default bold";
    }
    {
      pattern = "\\[image\\ [0-9]+\\]";
      color = "green default bold";
    }
    {
      pattern = "\\[embedded flash: [0-9][0-9]*\\]";
      color = "green default bold";
    }
    {
      pattern = ":.*\\(link\\)$";
      color = "cyan default";
    }
    {
      pattern = ":.*\\(image\\)$";
      color = "blue default";
    }
    {
      pattern = ":.*\\(embedded flash\\)$";
      color = "magenta default";
    }
    {
      pattern = "(^.$ .*|^.# .*)";
      color = "yellow default bold";
    }
  ];
  convertToString = argument: list: builtins.concatStringsSep "\n" (map argument list);
in
{
  programs.newsboat = {
    enable = true;
    autoReload = true;
    browser = "xdg-open";
    extraConfig = ''
      article-sort-order date-desc
      confirm-exit yes
      download-full-page yes
      show-read-articles no
      show-read-feeds no

      # Controls
      ${convertToString (control: "bind-key ${control.key} ${control.action}") controlsList}

      # Macros
      ${convertToString (macro: "macro ${macro.key} set browser \"${macro.action}\"; open-in-browser-and-mark-read; ${resetBrowser}") macroList}

      # Colors
      color listnormal white default
      color listfocus black yellow standout bold
      color listnormal_unread blue default
      color listfocus_unread yellow default bold
      color info red black bold
      color article white default bold

      highlight all "---.*---" yellow
      highlight feedlist ".*(0/0))" black
      ${convertToString (highlight: "highlight article \"${highlight.pattern}\" ${highlight.color}") articleColors}

      # Miniflux stuff
      urls-source "miniflux"
      miniflux-url "https://reader.miniflux.app"
      miniflux-login "nuclearcoffee"
      miniflux-passwordeval "${pkgs.rbw}/bin/rbw get 3fbefc6e-da23-4507-9d1e-af980166fdff"
    '';
    reloadThreads = 12;
  };
}
