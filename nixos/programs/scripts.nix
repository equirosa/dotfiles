{ pkgs
, lib
, config
, ...
}:
let
  inherit (builtins) attrValues readFile fetchTarball replaceStrings;
  inherit (lib) getExe optionalString;
  inherit (default-programs) http-browser;
  default-programs = import ../default-programs.nix { inherit pkgs lib; };
  aliases = import ../shell/aliases.nix { inherit pkgs lib; };
  inherit (aliases) cat;
  notify = ''${getExe pkgs.libnotify} -t 5000'';
  dmenu-command = "rofi -dmenu";
  backupIfDuplicate = ext: ''
    if [ "''${ext}" = "${ext}" ]; then
    bak="''${file}.bak"; mv "''${file}" "''${bak}"
    file="''${file}.bak"
    fi
  '';
  scriptAudio = "-c:a libopus -b:a 96k";
  check-updates = ''
    nixos-rebuild build --upgrade &&
    ${getExe pkgs.nvd} diff /run/current-system ./result && rm ./result
  '';
  check-modifications = replaceStrings [ "--upgrade" ] [ "" ] check-updates;
  terminal = "${getExe pkgs.foot}";
  geminiBrowser = "${getExe pkgs.lagrange}";
  # scriptFiles = filesIn { dir = ../../scripts; ext = "sh"; };
  getExeList = map (x: "${getExe pkgs.${x}}");
  shellApplicationWithInputs =
    { name
    , runtimeInputs ? [ ]
    , text
    , getFile ? false || getExt || getBase || getDir
    , getExt ? false
    , getBase ? false
    , getDir ? false
    }: (pkgs.writeShellApplication {
      inherit name runtimeInputs;
      text = ''
        [ $# -eq 0 ] && ${notify} "No arguments provided. Exitting..." && exit 1
        ${optionalString getFile ''file="$(readlink -f "''${1}")"'' }
        ${optionalString getExt "ext=\${file##*.}"}
        ${optionalString getBase "base=\${file%.*}"}
        ${optionalString getDir "directory=\${file%/*}"}
        ${text}
      '';
    });
in
{
  home.packages = with pkgs; [
    # Scripts
    (shellApplicationWithInputs {
      name = "2mkv";
      runtimeInputs = [ ffmpeg-full ];
      getBase = true;
      getExt = true;
      text = ''
        ${backupIfDuplicate "mkv"}
        ffmpeg -i "''${file}" -c:v libsvtav1 -preset 5 -crf 32 \
        -g 240 -pix_fmt yuv420p10le ${scriptAudio} "''${base}.mkv"
      '';
    })
    (shellApplicationWithInputs {
      name = "2ogg";
      getBase = true;
      getExt = true;
      text = ''
        ${backupIfDuplicate "ogg"}
        ${getExe ffmpeg} -i "''${file}" -vn ${scriptAudio} "''${base}.ogg"
      '';
    })
    (shellApplicationWithInputs {
      name = "2pdf";
      getExt = true;
      text = ''
        case "''${ext}" in
          odt | docx ) ${getExe libreoffice} --headless --convert-to pdf "''${1}" ;;
          * ) printf "I can't handle that format yet!\n"
        esac
      '';
    })
    (shellApplicationWithInputs {
      name = "2webp";
      getExt = true;
      getBase = true;
      text = replaceStrings [ "cwebp" ] [ "${libwebp}/bin/cwebp" ] ''
        case "''${ext}" in
        jpg | jpeg ) cwebp -q 80 "''${file}" -o "''${base}.webp" ;;
        png ) cwebp -lossless "''${file}" -o "''${base}.webp" ;;
        webp ) printf "File is already WEBP" && exit 1 ;;
        * ) printf "Can't handle that file extension..." && exit 1 ;;
        esac
      '';
    })
    (writeShellApplication {
      name = "nvim-clean";
      text = lib.fileContents ../../scripts/nvim-clean.sh;
    })
    (writeShellApplication {
      name = "change-background";
      text = readFile ../../scripts/change_background.sh;
    })
    (writeShellApplication {
      name = "check-modifications";
      text = check-modifications;
    })
    (writeShellApplication {
      name = "check-updates";
      text = check-updates;
    })
    (writeShellApplication {
      name = "code2png";
      text = replaceStrings [ "silicon" ] [ "${getExe silicon}" ]
        (readFile ../../scripts/code2png.sh);
    })
    (shellApplicationWithInputs {
      name = "download-file";
      text = ''
        setsid ${getExe yt-dlp} --sponsorblock-mark all \
        --embed-subs --embed-metadata \
        -o "%(title)s-[%(id)s].%(ext)s" "$1" >>/dev/null &
      '';
    })
    (writeShellApplication {
      name = "download-music-playlist";
      text = replaceStrings [ "yt-dlp" ] [ "${getExe yt-dlp}" ] ''
        SOURCE_FILE="Source - Playlists.txt"
        touch "''${SOURCE_FILE}"
        ${readFile "/home/kiri/projects/TheFrenchGhostys-Ultimate-YouTube-DL-Scripts-Collection/scripts/Audio-Only Scripts/Archivist Scripts/Playlists/Playlists.sh"}
      '';
    })
    (writeShellApplication {
      name = "download-music-unique";
      text = replaceStrings [ "yt-dlp" ] [ "${getExe yt-dlp}" ] ''
        SOURCE_FILE="Source - Unique.txt"
        touch "''${SOURCE_FILE}"
        ${readFile "/home/kiri/projects/TheFrenchGhostys-Ultimate-YouTube-DL-Scripts-Collection/scripts/Audio-Only Scripts/Archivist Scripts/Unique/Unique.sh"}
      '';
    })
    (writeShellApplication {
      name = "download-video-channel";
      text = replaceStrings [ "yt-dlp" ] [ "${getExe yt-dlp}" ] ''
        SOURCE_FILE="Source - Channels.txt"
        touch "''${SOURCE_FILE}"
        ${readFile "/home/kiri/projects/TheFrenchGhostys-Ultimate-YouTube-DL-Scripts-Collection/scripts/Archivist Scripts/Archivist Scripts (No Comments)/Channels/Channels.sh"}
      '';
    })
    (writeShellApplication {
      name = "download-video-playlist";
      text = replaceStrings [ "yt-dlp" ] [ "${getExe yt-dlp}" ] ''
        SOURCE_FILE="Source - Playlists.txt"
        touch "''${SOURCE_FILE}"
        ${readFile "/home/kiri/projects/TheFrenchGhostys-Ultimate-YouTube-DL-Scripts-Collection/scripts/Archivist Scripts/Archivist Scripts (No Comments)/Playlists/Playlists.sh"}
      '';
    })
    (writeShellApplication {
      name = "download-video-unique";
      text = replaceStrings [ "yt-dlp" ] [ "${getExe yt-dlp}" ] ''
        SOURCE_FILE="Source - Unique.txt"
        touch "''${SOURCE_FILE}"
        ${readFile "/home/kiri/projects/TheFrenchGhostys-Ultimate-YouTube-DL-Scripts-Collection/scripts/Archivist Scripts/Archivist Scripts (No Comments)/Unique/Unique.sh"}
      '';
    })
    (writeShellApplication {
      name = "emoji";
      runtimeInputs = [ (rofimoji.override { rofi = rofi-wayland; }) ];
      text = ''
        rofimoji --clipboarder wl-copy --action type copy --typer wtype
      '';
    })
    (writeShellApplication {
      name = "encrypt";
      text = ''
        ${getExe gnupg} --encrypt --recipient "eduardo@eduardoquiros.com" "$1" \
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
        ${http-browser} -p default "https://reader.miniflux.app/bookmarklet?uri=''${URL}"
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
    (shellApplicationWithInputs {
      name = "nixify";
      text = ''
        nix flake new -t github:numtide/devshell ."''${1}" \
        && cd "''${1}" \
        && ${getExe direnv} allow
        ''${EDITOR} flake.nix
      '';
    })
    (shellApplicationWithInputs {
      name = "password-menu";
      runtimeInputs = [ wtype ];
      text = ''${getExe rofi-rbw}'';
    })
    (writeShellApplication {
      name = "rem-lap";
      text = ''
        chosen=$(find "${config.xdg.dataHome}/remmina/" -name "*.remmina")

        [ "$(${coreutils}/bin/wc -l <<< "''${chosen}")" -gt 1 ] &&\
        chosen=$(${coreutils}/bin/printf "''${chosen}" | ${dmenu-command})

        ${getExe remmina} -c "$chosen"
      '';
    })
    (writeShellApplication {
      name = "run-backups";
      text = replaceStrings [ "rbw" "borg " ] [ "${getExe rbw}" "${getExe borgbackup} " ] ''
        ${readFile ../../scripts/run-backups.sh}
      '';
    })
    (writeShellApplication {
      name = "search";
      text = ''
        SEARCH_OPTIONS="searx.nixnet.services/search?q=\nyoutube.com/results?search_query=\ngithub.com/search?q=\nnixos.wiki/index.php?search=\nprotondb.com/search?q="
        SEARCH_SITE="$(echo -e "''${SEARCH_OPTIONS}" | ${dmenu-command} --prompt-text "Search website")"
        INPUT="$(${dmenu-command} --prompt-text "Search term")"
        ${http-browser} "''${SEARCH_SITE}''${INPUT}"
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
            *http*) setsid ${getExe yt-dlp} \
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
        case "''${1%%:*}" in
          gemini) ${geminiBrowser} "''${1}" ;;
          http|https|*.html) ${http-browser} "''${1}" ;;
          magnet|*.torrent)
            transmission-remote -a "''${1}" && ${notify} "Torrent Added! ✅";;
          *.org) emacsclient --create-frame "''${1}" ;;
          *.png|*.jpg|*.jpeg|*.webp) ${getExe imv} "''${1}" ;;
          *.pdf) setsid ${http-browser} "''${1}" ;;
          *) ${xdg-utils}/bin/xdg-open "''${1}" ;;
        esac
      '';
    })
  ];
}