{
  pkgs,
  config,
  ...
}: let
  resetBrowser = ''set browser "xdg-open"'';
in {
  home-manager.users.kiri.programs.newsboat = {
    enable = true;
    autoReload = true;
    browser = "xdg-open";
    extraConfig = ''
      article-sort-order date-desc
      confirm-exit yes
      download-full-page yes
      show-read-articles no
      show-read-feeds no

      browser xdg-open

      # Controls
      bind-key j down
      bind-key k up
      bind-key j next articlelist
      bind-key k prev articlelist
      bind-key G end
      bind-key g home
      bind-key a toggle-article-read
      bind-key l open
      bind-key h quit
      bind-key u show-urls
      bind-key T toggle-show-read-feeds
      bind-key O open-in-browser-and-mark-read

      # Macros
      macro m set browser "${pkgs.mpv}/bin/mpv"; open-in-browser-and-mark-read; ${resetBrowser}
      macro u set browser "${pkgs.mpv}/bin/umpv"; open-in-browser-and-mark-read; ${resetBrowser}
      macro w set browser "${pkgs.w3m}/bin/w3m"; open-in-browser-and-mark-read ; ${resetBrowser}
      macro b set browser "firefox"; open-in-browser-and-mark-read ; ${resetBrowser}
      macro d set browser "watchlist"; open-in-browser-and-mark-read ; ${resetBrowser}

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
      miniflux-passwordeval "gopass show websites/miniflux.app/nuclearcoffee"
    '';
    reloadThreads = 12;
  };
}
