{
  pkgs,
  lib,
  ...
}: let
  notify = ''${pkgs.libnotify}/bin/notify-send -t 5000'';
  pdf-reader = "${pkgs.zathura}/bin/zathura";
  dmenu-command = "${pkgs.rofi-wayland}/bin/rofi -dmenu";
  exitWithNoArguments = ''[ $# -eq 0 ] && ${notify} "No arguments provided. Exitting..." && exit 1'';
  getFile = ''file="$(readlink -f "''${1}")"'';
  getExt = ''ext=''${file##*.}'';
  getDir = ''directory=''${file%/*}'';
  getBase = ''base=''${file%.*}'';
  backupFile = ''bak="''${file}.bak"; mv "''${file}" "''${bak}"'';
  terminal = "${pkgs.foot}/bin/foot";
  geminiBrowser = "${pkgs.lagrange}/bin/lagrange";
in {
  imports = [./emacs.nix ./flatpak.nix ./git.nix ./kitty.nix ./lf.nix ./mpv.nix ./newsboat.nix];
  home-manager.users.kiri = {config, ...}: {
    home.packages = with pkgs; [
      # Browsers
      buku # play with bookmarks
      firefox
      # librewolf
      qutebrowser
      tor-browser-bundle-bin
      lagrange
      # Messengers
      aerc
      element-desktop
      # Documents
      libreoffice
      hunspell
      hunspellDicts.en-us-large
      hunspellDicts.es-any
      pandoc
      # Editor
      # TODO: consider using the home-manager built-in way
      neovim
      # File Sharing
      ffsend
      onionshare-gui
      transmission
      tremc
      wormhole-william
      # Nix-specific stuff
      cachix
      comma
      nix-update
      nixpkgs-review
      rnix-lsp
      # Utilities
      archiver
      borgbackup
      cryfs
      czkawka
      du-dust
      fd
      gopass
      gopass-jsonapi
      imv
      kopia
      libnotify
      ripgrep
      tealdeer
      trash-cli
      ytfzf
      # Scripts
      (writeShellApplication {
        name = "2mkv";
        runtimeInputs = [ffmpeg-full];
        text = ''
          ${exitWithNoArguments}
          ${getFile}
          ${getBase}
          ${backupFile}
          ffmpeg -i "''${file}.bak" -c:v libsvtav1 -preset 5 -crf 32 -g 240 -pix_fmt yuv420p10le -c:a libopus "''${base}.mkv"
        '';
      })
      (writeShellApplication {
        name = "2ogg";
        text = ''
          ${exitWithNoArguments}
          ${getFile}
          ${getBase}
          ${pkgs.ffmpeg}/bin/ffmpeg -i "''${file}" "''${base}.ogg"
        '';
      })
      (writeShellApplication {
        name = "2pdf";
        runtimeInputs = [pandoc libreoffice];
        text = ''
          ${exitWithNoArguments}
          ${getFile}
          ${getExt}
          case "''${ext}" in
            odt ) libreoffice --headless --convert-to pdf "''${1}" ;;
          esac
        '';
      })
      (writeShellApplication {
        name = "2webp";
        runtimeInputs = [libwebp];
        text = ''
          ${exitWithNoArguments}
          ${getFile}
          ${getBase}
          ${getExt}
          case "''${ext}" in
          jpg | jpeg ) cwebp -q 80 "''${file}" -o "''${base}.webp" ;;
          png ) cwebp -lossless "''${file}" -o "''${base}.webp" ;;
          * ) printf "Can't handle that file extension..." && exit 1 ;;
          esac
        '';
      })
      (writeShellApplication {
        name = "check-modifications";
        text = ''
          nixos-rebuild build --upgrade && ${lib.getBin pkgs.nvd}/bin/nvd diff /run/current-system ./result && rm ./result
        '';
      })
      (writeShellApplication {
        name = "download-file";
        text = ''
          ${exitWithNoArguments}
          setsid ${pkgs.yt-dlp}/bin/yt-dlp --sponsorblock-mark all \
          --embed-subs --embed-metadata -o "%(title)s-[%(id)s].%(ext)s" "$1" >>/dev/null &
        '';
      })
      (writeShellApplication {
        name = "download-music-playlist";
        runtimeInputs = [yt-dlp];
        text = ''
          SOURCE_FILE="Source - Playlists.txt"
          touch "''${SOURCE_FILE}"
          ${builtins.readFile "/home/kiri/projects/TheFrenchGhostys-Ultimate-YouTube-DL-Scripts-Collection/scripts/Audio-Only Scripts/Archivist Scripts/Playlists/Playlists.sh"}
        '';
      })
      (writeShellApplication {
        name = "download-music-unique";
        runtimeInputs = [yt-dlp];
        text = ''
          SOURCE_FILE="Source - Unique.txt"
          touch "''${SOURCE_FILE}"
          ${builtins.readFile "/home/kiri/projects/TheFrenchGhostys-Ultimate-YouTube-DL-Scripts-Collection/scripts/Audio-Only Scripts/Archivist Scripts/Unique/Unique.sh"}
        '';
      })
      (writeShellApplication {
        name = "download-video-playlist";
        runtimeInputs = [yt-dlp];
        text = ''
          SOURCE_FILE="Source - Playlists.txt"
          touch "''${SOURCE_FILE}"
          ${builtins.readFile "/home/kiri/projects/TheFrenchGhostys-Ultimate-YouTube-DL-Scripts-Collection/scripts/Archivist Scripts/Archivist Scripts (No Comments)/Playlists/Playlists.sh"}
        '';
      })
      (writeShellApplication {
        name = "download-video-unique";
        runtimeInputs = [yt-dlp];
        text = ''
          SOURCE_FILE="Source - Unique.txt"
          touch "''${SOURCE_FILE}"
          ${builtins.readFile "/home/kiri/projects/TheFrenchGhostys-Ultimate-YouTube-DL-Scripts-Collection/scripts/Archivist Scripts/Archivist Scripts (No Comments)/Unique/Unique.sh"}
        '';
      })
      (writeShellApplication {
        name = "emoji";
        runtimeInputs = with pkgs; [wl-clipboard wofi];
        text = ''
          ${pkgs.wofi-emoji}/bin/wofi-emoji
        '';
      })
      (writeShellApplication {
        name = "encrypt";
        text = ''
          ${pkgs.gnupg}/bin/gpg --encrypt --recipient "eduardo@eduardoquiros.com" "$1" \
          && ${notify} "🔒 encrypting..." \
          && ${pkgs.coreutils}/bin/shred --remove "$1" \
          && ${notify} "❌ file deleted"
        '';
      })
      (writeShellApplication {
        name = "feed-subscribe";
        text = ''
          if [ $# -eq 0 ]; then
            URL="$(${dmenu-command} -p Enter URL)"
          else
            URL="''${1}"
          fi
          YOUTUBE_URI="$(sed -e 's/piped.kavin.rocks/youtube.com/g' -e 's/piped.mint.lgbt/youtube.com/g' -e 's/il.ax/youtube.com/g' -e 'piped.privacy.com.de/youtube.com/g' <<< "''${URL}")"
          ${config.home.sessionVariables.BROWSER} "https://reader.miniflux.app/bookmarklet?uri=''${YOUTUBE_URI}"
        '';
      })
      (writeShellApplication {
        name = "gen-ssh-key";
        text = ''
          ssh-keygen -t ed25519 -a 100
        '';
      })
      (writeShellApplication {
        name = "join-class";
        text = ''
          chosen="$(${dmenu-command} < ~/links.csv | cut -d ' ,' -f2)"
          [ -z "''${chosen}" ] && exit 1
          xdg-open "''${chosen}"
        '';
      })
      (writeShellApplication {
        name = "nixify";
        text = ''
          ${exitWithNoArguments}
          ${pkgs.nix}/bin/nix flake new -t github:nix-community/nix-direnv "''${1}" \
          && cd "''${1}" \
          && ${pkgs.direnv}/bin/direnv allow
          ''${EDITOR} flake.nix
        '';
      })
      (writeShellApplication {
        name = "password-menu";
        text = ''
          ${exitWithNoArguments}
          SUBCOMMAND="''${1}"

          CHOSEN="$(${pkgs.gopass}/bin/gopass ls -f | ${dmenu-command})"

          exec ${pkgs.gopass}/bin/gopass "''${SUBCOMMAND}" -c -o "''${CHOSEN}"
        '';
      })
      (writeShellApplication {
        name = "rem-lap";
        text = ''
          chosen=$(find "${config.xdg.dataHome}/remmina/" -name "*.remmina")

          [ "$(${pkgs.coreutils}/bin/wc -l <<< "''${chosen}")" -gt 1 ] &&\
          chosen=$(${pkgs.coreutils}/bin/printf "''${chosen}" | ${dmenu-command})

          ${pkgs.remmina}/bin/remmina -c "$chosen"
        '';
      })
      (writeShellApplication {
        name = "search";
        text = ''
          SEARCH_OPTIONS="search.nixnet.services/search?q=\nyoutube.com/results?search_query=\ngithub.com/search?q="
          SEARCH_SITE="$(echo -e "''${SEARCH_OPTIONS}" | ${dmenu-command} -p "Search website")"
          INPUT="$(${dmenu-command} -p "Search term")"
          ${config.home.sessionVariables.BROWSER} "''${SEARCH_SITE}''${INPUT}"
        '';
      })
      (writeShellApplication {
        name = "show-ansi-escapes";
        text = ''
          for i in 30 31 32 33 34 35 36 37 38; do
          ${pkgs.coreutils}/bin/printf "\033[0;''${i}m Normal: (0;''${i}); \033[1;''${i}m Bold: (1;''${i});\n"
          done
        '';
      })
      (writeShellApplication {
        name = "show-nix-store-path";
        text = ''
          ${pkgs.coreutils}/bin/readlink -f "$(command -v "$@")"
        '';
      })
      (writeShellApplication {
        name = "watchlist";
        text = ''
          case "''${1}" in
            *http*) setsid ${pkgs.yt-dlp}/bin/yt-dlp \
              --sponsorblock-mark all\
              --embed-subs\
              --embed-metadata\
              -o "${config.home.homeDirectory}/Videos/watchlist/$(date +%s)-%(title)s-[%(id)s].%(ext)s"\
            "$1" >>/dev/null & ;;
            "") setsid ${pkgs.mpv}/bin/umpv "${config.home.homeDirectory}/Videos/watchlist/" ;;
            *) setsid mv "''${1}" "${config.home.homeDirectory}/Videos/watchlist/$(date +%s)-''${1}" ;;
          esac
        '';
      })
      (writeShellApplication {
        name = "xdg-open";
        text = ''
          case "''${1}" in
            gemini* ) ${geminiBrowser} "''${@}" ;;
            *youtube.com/watch* | *youtu.be/* | *tilvids.com/w/* | *twitch.tv/* | *bitcointv.com/w/* | *peertube.co.uk/w/* | *videos.lukesmith.xyz/w/* | *diode.zone/w/* | *peertube.thenewoil.xyz/videos/watch/* | *share.tube/w/* ) setsid ${mpv}/bin/umpv "''${1}" & ;;
            http* | *.html ) ${config.home.sessionVariables.BROWSER} "''${@}" ;;
            magnet* | *.torrent ) transmission-remote -a "''${1}" && ${notify} "Torrent Added! ✅" && exit 0 ;;
            *.org ) emacsclient --create-frame "''${1}" ;;
            *.png | *.jpg | *.jpeg | *.webp ) ${pkgs.imv}/bin/imv "''${@}" ;;
            *.pdf ) setsid ${pdf-reader} "''${@}" ;;
            * ) ${pkgs.xdg-utils}/bin/xdg-open "''${@}" ;;
          esac
        '';
      })
    ];
  };
}
