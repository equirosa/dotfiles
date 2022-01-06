{ pkgs, lib, ... }:
let
  pdf-reader = "${pkgs.zathura}/bin/zathura";
  writeDashScript = name: content: (pkgs.writeScriptBin "${name}" ''
    #!${pkgs.dash}/bin/dash
    ${content}
  '');
in
{
  home-manager.users.kiri = { config, ... }: {
    home.packages = with pkgs; [
      # Browsers
      nur.repos.wolfangaukang.librewolf

      # Messengers
      discord # UNFREE
      schildichat-desktop

      # Editor
      neovim

      # Utilities
      gopass
      gopass-jsonapi
      tealdeer
      wormhole-william

      # Scripts
      (writeDashScript "rem-lap" ''
        chosen=$(find "${config.xdg.dataHome}/remmina/" -name "*.remmina")

        [ "$(${pkgs.coreutils}/bin/printf "$chosen" | ${pkgs.coreutils}/bin/wc -l)" -gt 1 ] &&\
        chosen=$(${pkgs.coreutils}/bin/printf "$chosen" | menu)

        ${pkgs.remmina}/bin/remmina -c "$chosen"
      '')
      (writeDashScript "show-ansi-escapes" ''
        for i in 30 31 32 33 34 35 36 37 38; do
        ${pkgs.coreutils}/bin/printf "\033[0;"$i"m Normal: (0;$i); \033[1;"$i"m Light: (1;$i);\n"
        done
      '')
      (writeDashScript "watchlist" ''
        case "$1" in
          *http*) setsid ${pkgs.yt-dlp}/bin/yt-dlp --restrict-filenames\
            --sponsorblock-mark all\
            --embed-subs\
            --embed-metadata\
            -o "${config.home.homeDirectory}/Videos/watchlist/$(date +%s)-%(title)s-[%(id)s].%(ext)s"\
          "$1" >>/dev/null & ;;
          "") setsid ${pkgs.mpv}/bin/umpv "${config.home.homeDirectory}/Videos/watchlist/" ;;
          *) setsid mv "$1" "${config.home.homeDirectory}/Videos/watchlist/$(date +%s)-$1" ;;
        esac
      '')
      (writeShellApplication {
        name = "xdg-open";
        runtimeInputs = [ ];
        text = ''
          case "$1" in
            *youtube.com/watch* | *youtu.be/* | *twitch.tv/* | *peertube.co.uk/videos/* | *videos.lukesmith.xyz/w/* ) setsid ${mpv}/bin/umpv "$1" & ;;
            http* ) ${pkgs.qutebrowser}/bin/qutebrowser "$1" ;;
            *.pdf ) setsid ${pdf-reader} "$1" ;;
            * ) ${pkgs.xdg-utils}/bin/xdg-open "$1" ;;
          esac
        '';
      })
    ];
  };
}
