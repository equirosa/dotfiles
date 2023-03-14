{ pkgs, config, lib, ... }:
let
  resetBrowser = ''set browser "xdg-open"'';
  inherit (config.home.sessionVariables) BROWSER;
  inherit (lib) getExe;
  macroList = [
    { key = "m"; action = "mpv --keep-open=no --pause"; }
    { key = "u"; action = "umpv"; }
    { key = "w"; action = "${getExe pkgs.w3m}"; }
    { key = "b"; action = BROWSER; }
    { key = "d"; action = "watchlist"; }
  ];
  controlsList = [
    { key = "j"; action = "down"; }
    { key = "k"; action = "up"; }
    { key = "j"; action = "next articlelist"; }
    { key = "k"; action = "prev articlelist"; }
    { key = "G"; action = "end"; }
    { key = "g"; action = "home"; }
    { key = "a"; action = "toggle-article-read"; }
    { key = "l"; action = "open"; }
    { key = "h"; action = "quit"; }
    { key = "u"; action = "show-urls"; }
    { key = "T"; action = "toggle-show-read-feeds"; }
    { key = "O"; action = "open-in-browser-and-mark-read"; }
  ];
  convertToString = list: builtins.concatStringsSep "\n" list;
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
      ${convertToString (map (control: "bind-key ${control.key} ${control.action}") controlsList)}

      # Macros
      ${convertToString (map (macro: "macro ${macro.key} set browser \"${macro.action}\"; open-in-browser-and-mark-read; ${resetBrowser}") macroList)}

      # Colors
      color listnormal white default
      color listfocus black yellow standout bold
      color listnormal_unread blue default
      color listfocus_unread yellow default bold
      color info red black bold
      color article white default bold

      highlight all "---.*---" yellow
      highlight feedlist ".*(0/0))" black
      highlight article "(^Feed:.*|^Title:.*|^Author:.*)" cyan default bold
      highlight article "(^Link:.*|^Date:.*)" default default
      highlight article "https?://[^ ]+" green default
      highlight article "^(Title):.*$" blue default
      highlight article "\\[[0-9][0-9]*\\]" magenta default bold
      highlight article "\\[image\\ [0-9]+\\]" green default bold
      highlight article "\\[embedded flash: [0-9][0-9]*\\]" green default bold
      highlight article ":.*\\(link\\)$" cyan default
      highlight article ":.*\\(image\\)$" blue default
      highlight article ":.*\\(embedded flash\\)$" magenta default
      highlight article "(^.$ .*|^.# .*)" yellow default bold

      # Miniflux stuff
      urls-source "miniflux"
      miniflux-url "https://reader.miniflux.app"
      miniflux-login "nuclearcoffee"
      miniflux-passwordeval "${pkgs.rbw}/bin/rbw get 3fbefc6e-da23-4507-9d1e-af980166fdff"
    '';
    reloadThreads = 12;
  };
}
