{ pkgs
, lib
, ...
}:
let
  inherit (builtins) attrValues readFile fetchTarball replaceStrings;
  notify = ''${pkgs.libnotify}/bin/notify-send -t 5000'';
  cat = "${pkgs.bat}/bin/bat --plain";
  dmenu-command = "rofi -dmenu";
  exitWithNoArguments = ''[ $# -eq 0 ] && ${notify} "No arguments provided. Exitting..." && exit 1'';
  backupIfDuplicate = ext: ''if [ "''${ext}" = "${ext}" ];
  then
  ${backupFile}
  export file="''${file}.bak"
  fi
  '';
  getFile = ''file="$(readlink -f "''${1}")"'';
  getExt = ''ext=''${file##*.}'';
  getDir = ''directory=''${file%/*}'';
  getBase = ''base=''${file%.*}'';
  scriptAudio = "-c:a libopus -b:a 96k";
  backupFile = ''bak="''${file}.bak"; mv "''${file}" "''${bak}"'';
  terminal = "${pkgs.foot}/bin/foot";
  geminiBrowser = "${pkgs.lagrange}/bin/lagrange";
in
{
  imports = [
    ./flatpak.nix
  ];
  nixpkgs.overlays = [
    (import
      (fetchTarball {
        url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
      }))
    (import (fetchTarball {
      url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
  ];
  home-manager.users.kiri = { config, ... }: {
    imports = [
      ./browsers/firefox.nix
      ./emacs.nix
      ./git.nix
      ./kitty.nix
      ./lf.nix
      ./mpv.nix
      ./neovim.nix
      ./newsboat
      ./rofi.nix
    ];
    home.packages = with pkgs;
      [
        # Browsers
        tor-browser-bundle-bin
        lagrange
        nyxt
        # Messengers
        aerc catimg
        element-desktop
        # Documents
        onlyoffice-bin
        hunspell
        hunspellDicts.en-us-large
        hunspellDicts.es-any
        pandoc
        tectonic
        texlive.combined.scheme-full # For latex exports
        # File Sharing
        ffsend
        transmission
        tremc
        wormhole-rs
        # Nix-specific stuff
        cachix
        comma
        nix-template
        nix-update
        nixpkgs-review
        statix
        # LISP
        sbcl
        # Utilities
        archiver
        borgbackup
        cryfs
        czkawka
        du-dust
        fd
        imv
        libnotify
        qpwgraph
        ripgrep
        trash-cli
        ytfzf
        # Password
        gopass
        gopass-jsonapi
        # Scripts
        (writeShellApplication {
          name = "2mkv";
          runtimeInputs = [ ffmpeg-full ];
          text = ''
            ${exitWithNoArguments}
            ${getFile}
            ${getBase}
            ${getExt}
            ${backupIfDuplicate "mkv"}
            ffmpeg -i "''${file}" -c:v libsvtav1 -preset 5 -crf 32 \
            -g 240 -pix_fmt yuv420p10le ${scriptAudio} "''${base}.mkv"
          '';
        })
        (writeShellApplication {
          name = "2ogg";
          text = ''
            ${exitWithNoArguments}
            ${getFile}
            ${getBase}
            ${getExt}
            ${backupIfDuplicate "ogg"}
            ${ffmpeg}/bin/ffmpeg -i "''${file}" -vn ${scriptAudio} "''${base}.ogg"
          '';
        })
        (writeShellApplication {
          name = "2pdf";
          runtimeInputs = [ pandoc ];
          text = ''
            ${exitWithNoArguments}
            ${getFile}
            ${getExt}
            case "''${ext}" in
              # odt | docx ) , libreoffice --headless --convert-to pdf "''${1}" ;;
              * ) printf "I can't handle that format yet!\n"
            esac
          '';
        })
        (writeShellApplication {
          name = "2webp";
          runtimeInputs = [ libwebp ];
          text = replaceStrings [ "cwebp" ] [ "${libwebp}/bin/cwebp" ] ''
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
            nixos-rebuild build --upgrade \
            && ${nvd}/bin/nvd diff /run/current-system ./result && rm ./result
          '';
        })
        (writeShellApplication {
          name = "download-file";
          text = ''
            ${exitWithNoArguments}
            setsid ${yt-dlp}/bin/yt-dlp --sponsorblock-mark all \
            --embed-subs --embed-metadata \
            -o "%(title)s-[%(id)s].%(ext)s" "$1" >>/dev/null &
          '';
        })
        (writeShellApplication {
          name = "download-music-playlist";
          runtimeInputs = [ yt-dlp ];
          text = ''
            SOURCE_FILE="Source - Playlists.txt"
            touch "''${SOURCE_FILE}"
            ${readFile "/home/kiri/projects/TheFrenchGhostys-Ultimate-YouTube-DL-Scripts-Collection/scripts/Audio-Only Scripts/Archivist Scripts/Playlists/Playlists.sh"}
          '';
        })
        (writeShellApplication {
          name = "download-music-unique";
          runtimeInputs = [ yt-dlp ];
          text = ''
            SOURCE_FILE="Source - Unique.txt"
            touch "''${SOURCE_FILE}"
            ${readFile "/home/kiri/projects/TheFrenchGhostys-Ultimate-YouTube-DL-Scripts-Collection/scripts/Audio-Only Scripts/Archivist Scripts/Unique/Unique.sh"}
          '';
        })
        (writeShellApplication {
          name = "download-video-playlist";
          runtimeInputs = [ yt-dlp ];
          text = ''
            SOURCE_FILE="Source - Playlists.txt"
            touch "''${SOURCE_FILE}"
            ${readFile "/home/kiri/projects/TheFrenchGhostys-Ultimate-YouTube-DL-Scripts-Collection/scripts/Archivist Scripts/Archivist Scripts (No Comments)/Playlists/Playlists.sh"}
          '';
        })
        (writeShellApplication {
          name = "download-video-unique";
          runtimeInputs = [ yt-dlp ];
          text = ''
            SOURCE_FILE="Source - Unique.txt"
            touch "''${SOURCE_FILE}"
            ${readFile "/home/kiri/projects/TheFrenchGhostys-Ultimate-YouTube-DL-Scripts-Collection/scripts/Archivist Scripts/Archivist Scripts (No Comments)/Unique/Unique.sh"}
          '';
        })
        (writeShellApplication {
          name = "emoji";
          runtimeInputs = [
            (rofimoji.override { rofi = rofi-wayland; })
          ];
          text = ''
            rofimoji --clipboarder wl-copy --action type copy --typer wtype
          '';
        })
        (writeShellApplication {
          name = "encrypt";
          text = ''
            ${gnupg}/bin/gpg --encrypt --recipient "eduardo@eduardoquiros.com" "$1" \
            && ${notify} "🔒 encrypting..." \
            && ${coreutils}/bin/shred --remove "$1" \
            && ${notify} "❌ file deleted"
          '';
        })
        (writeShellApplication {
          name = "feed-subscribe";
          text = ''
            if [ $# -eq 0 ]; then
              URL="$(${dmenu-command} --prompt-text Enter URL)"
            else
              URL="''${1}"
            fi
            YOUTUBE_URI="$(link2youtube <<< "''${URL}")"
            ${config.home.sessionVariables.BROWSER} -p default "https://reader.miniflux.app/bookmarklet?uri=''${YOUTUBE_URI}"
          '';
        })
        (writeShellApplication {
          name = "link2youtube";
          text = ''
            sed -e 's/piped.kavin.rocks/youtube.com/g' \
                -e 's/piped.mint.lgbt/youtube.com/g' \
                -e 's/il.ax/youtube.com/g' \
                -e 's/piped.privacy.com.de/youtube.com/g' \
                -e 's/piped.esmailelbob.xyz/youtube.com/g' \
                -e 's/yt.jae.fi/youtube.com/g'
          '';
        })
        (writeShellApplication {
          name = "gen-ssh-key";
          text = ''
            ssh-keygen -t ed25519 -a 100
          '';
        })
        (writeShellApplication {
          name = "git-remove-merged-branches";
          text = ''
            git for-each-ref --format '%(refname:short)' refs/heads \
                | grep -v "master\|main\|dev" \
                | xargs git branch -D
          '';
        })
        (writeShellApplication {
          name = "join-class";
          text = ''
            chosen="$(${dmenu-command} < ~/links.csv | cut -d ',' -f2)"
            [ -z "''${chosen}" ] && exit 1
            ${config.home.sessionVariables.BROWSER} -p default "''${chosen}"
          '';
        })
        (writeShellApplication {
          name = "nixify";
          text = ''
            ${exitWithNoArguments}
            nix flake new -t github:numtide/devshell ."''${1}" \
            && cd "''${1}" \
            && ${direnv}/bin/direnv allow
            ''${EDITOR} flake.nix
          '';
        })
        (writeShellApplication {
          name = "password-menu";
          text = ''
            ${exitWithNoArguments}
            CHOSEN="$(gopass list --flat | ${dmenu-command})"
            exec gopass show --clip "''${CHOSEN}"
          '';
        })
        (writeShellApplication {
          name = "otp-menu";
          text = ''
            ${exitWithNoArguments}
            CHOSEN="$(gopass list --flat | ${dmenu-command})"
            exec gopass otp --clip "''${CHOSEN}"
          '';
        })
        (writeShellApplication {
          name = "rem-lap";
          text = ''
            chosen=$(find "${config.xdg.dataHome}/remmina/" -name "*.remmina")

            [ "$(${coreutils}/bin/wc -l <<< "''${chosen}")" -gt 1 ] &&\
            chosen=$(${coreutils}/bin/printf "''${chosen}" | ${dmenu-command})

            ${remmina}/bin/remmina -c "$chosen"
          '';
        })
        (writeShellApplication {
          name = "run-backups";
          runtimeInputs = attrValues { inherit (pkgs) borgbackup; };
          text = ''
            ${readFile ../../scripts/run-backups.sh}
          '';
        })
        (writeShellApplication {
          name = "search";
          text = ''
            SEARCH_OPTIONS="searx.nixnet.services/search?q=\nyoutube.com/results?search_query=\ngithub.com/search?q=\nnixos.wiki/index.php?search=\nprotondb.com/search?q="
            SEARCH_SITE="$(echo -e "''${SEARCH_OPTIONS}" | ${dmenu-command} --prompt-text "Search website")"
            INPUT="$(${dmenu-command} --prompt-text "Search term")"
            ${config.home.sessionVariables.BROWSER} "''${SEARCH_SITE}''${INPUT}"
          '';
        })
        (writeShellApplication {
          name = "show-ansi-escapes";
          text = ''
            for i in 30 31 32 33 34 35 36 37 38; do
            ${coreutils}/bin/printf "\033[0;''${i}m Normal: (0;''${i}); \033[1;''${i}m Bold: (1;''${i});\n"
            done
          '';
        })
        (writeShellApplication {
          name = "show-nix-store-path";
          text = ''${coreutils}/bin/readlink -f "$(command -v "$@")" '';
        })
        (writeShellApplication {
          name = "show-script";
          text = ''
            ${cat} "$(show-nix-store-path "''${1}")"
          '';
        })
        (writeShellApplication {
          name = "watchlist";
          text =
            let
              inherit (config.xdg.userDirs) videos;
            in
            ''
              case "''${1}" in
                *http*) setsid ${yt-dlp}/bin/yt-dlp \
                  --sponsorblock-mark all\
                  --embed-subs\
                  --embed-metadata\
                  -o "${videos}/watchlist/$(date +%s)-%(title)s-[%(id)s].%(ext)s"\
                "$1" >>/dev/null & ;;
                "") setsid umpv "${videos}/watchlist/" ;;
                *) setsid mv "''${1}" "${videos}/watchlist/$(date +%s)-''${1}" ;;
              esac
            '';
        })
        (writeShellApplication {
          name = "xdg-open";
          text = ''
            case "''${1}" in
              gemini* ) ${geminiBrowser} "''${@}" ;;
              *youtube.com/watch* | *youtu.be/* | *tilvids.com/w/* | *twitch.tv/* | *bitcointv.com/w/* | *peertube.co.uk/w/* | *videos.lukesmith.xyz/w/* | *diode.zone/w/* | *peertube.thenewoil.xyz/videos/watch/* | *share.tube/w/* ) setsid umpv "''${1}" & ;;
              http* | *.html ) ${config.home.sessionVariables.BROWSER} "''${@}" ;;
              magnet* | *.torrent ) transmission-remote -a "''${1}" && ${notify} "Torrent Added! ✅" && exit 0 ;;
              *.org ) emacsclient --create-frame "''${1}" ;;
              *.png | *.jpg | *.jpeg | *.webp ) ${imv}/bin/imv "''${@}" ;;
              *.pdf ) setsid ${config.home.sessionVariables.BROWSER} -p default "''${@}" ;;
              * ) ${xdg-utils}/bin/xdg-open "''${@}" ;;
            esac
          '';
        })
      ]
      ++ import ./editorPackages.nix { inherit pkgs; };
  };
}
