{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (builtins) replaceStrings;
  inherit (lib) getExe optionalString fileContents;
  inherit (import ../../shell/aliases.nix {inherit pkgs lib;}) cat;
  notify = "${getExe pkgs.libnotify} -t 5000";
  menu-program = "rofi -dmenu";
  backupIfDuplicate = ext: ''
    if [ "''${ext}" = "${ext}" ]; then
    bak="''${file}.bak"; mv "''${file}" "''${bak}"
    file="''${file}.bak"
    fi
  '';
  ffmpeg-bin = "${pkgs.ffmpeg_6-full}/bin/ffmpeg";
  scriptAudio = "-c:a libopus -b:a 128k";
  getExeList = map (x: "${getExe pkgs.${x}}");
  stringsToReplace = ["rbw" "silicon" "nvd" "pngquant" "swappy"];
  shellApplicationFromList =
    map
    (name:
      pkgs.writeShellApplication {
        inherit name;
        text =
          replaceStrings
          (stringsToReplace ++ ["grimshot"])
          ((getExeList stringsToReplace) ++ [(getExe pkgs.sway-contrib.grimshot)])
          "${fileContents ./${name}.sh}";
      });
  shellApplicationWithInputs = {
    name,
    runtimeInputs ? [],
    text,
    getFile ? false || getExt || getBase || getDir,
    getExt ? false,
    getBase ? false,
    getDir ? false,
  }: (pkgs.writeShellApplication {
    inherit name runtimeInputs;
    text = ''
      [ $# -eq 0 ] && ${notify} "No arguments provided. Exitting..." && exit 1
      ${optionalString getFile ''file="$(realpath "''${1}")"''}
      ${optionalString getExt "ext=\${file##*.}"}
      ${optionalString getBase "base=\${file%.*}"}
      ${optionalString getDir "directory=\${file%/*}"}
      ${text}
    '';
  });
in {
  home.packages = with pkgs;
    [
      (shellApplicationWithInputs {
        name = "2mkv";
        getBase = true;
        getExt = true;
        text = ''
          ${backupIfDuplicate "mkv"}
          ${ffmpeg-bin} -i "''${file}" -c:v librav1e -preset 5 \
          -crf 30 -g 240 -pix_fmt yuv420p10le ${scriptAudio} "''${base}.mkv"
        '';
      })
      (shellApplicationWithInputs {
        name = "2ogg";
        getBase = true;
        getExt = true;
        text = ''
          ${backupIfDuplicate "ogg"}
          ${ffmpeg-bin} -i "''${file}" -vn ${scriptAudio} "''${base}.ogg"
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
        name = "2org";
        getExt = true;
        text = ''
          case "''${ext}" in
            odt | docx ) ${getExe pandoc} "''${1}" -o "''${file}.org" ;;
            * ) printf "I can't handle that format yet!\n"
          esac
        '';
      })
      (shellApplicationWithInputs {
        name = "2webp";
        getExt = true;
        getBase = true;
        text = let
          cwebp = "${libwebp}/bin/cwebp";
        in ''
          case "''${ext}" in
          jpg | jpeg ) ${cwebp} -q 80 "''${file}" -o "''${base}.webp" ;;
          png ) ${cwebp} -lossless "''${file}" -o "''${base}.webp" ;;
          webp ) printf "File is already WEBP" && exit 1 ;;
          * ) printf "Can't handle that file extension..." && exit 1 ;;
          esac
        '';
      })
      (shellApplicationWithInputs {
        name = "download-media";
        text = ''
          setsid ${getExe yt-dlp} --sponsorblock-mark all \
          --embed-subs --embed-metadata \
          -o "%(title)s-[%(id)s].%(ext)s" "$1" >>/dev/null &
        '';
      })
      (writeShellApplication {
        name = "emoji";
        runtimeInputs = [(rofimoji.override {rofi = rofi-wayland;})];
        text = ''
          rofimoji --clipboarder wl-copy --action type copy --typer wtype
        '';
      })
      (writeShellApplication {
        name = "feed-subscribe";
        text = ''
          if [ $# -eq 0 ]; then
            url="$(${menu-program} --prompt-text Enter url)"
          else
            url="''${1}"
          fi
          firefox -p default "https://reader.miniflux.app/bookmarklet?uri=''${url}"
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
        name = "optimize-size";
        getExt = true;
        text = ''
          output="''$(mktemp)"
          cp "''${file}" "''${output}"
          case "''${ext}" in
            jpeg|jpg)
              ${mozjpeg}/bin/jpegtran -copy none -optimize -progressive "''${output}" > "''${file}" ;;
          esac
        '';
      })
      (shellApplicationWithInputs {
        name = "password-menu";
        runtimeInputs = [wtype];
        text = ''${getExe rofi-rbw}'';
      })
      (writeShellApplication {
        name = "rem-lap";
        text = ''
          chosen=$(find "${config.xdg.dataHome}/remmina/" -name "*.remmina")

          [ "$(${coreutils}/bin/wc -l <<< "''${chosen}")" -gt 1 ] &&\
          chosen=$(${coreutils}/bin/printf "''${chosen}" | ${menu-program})

          ${getExe remmina} -c "$chosen"
        '';
      })
      (writeShellApplication {
        name = "search";
        text = ''
          search_options="farside.link/whoogle/search?q=\nyoutube.com/results?search_query=\ngithub.com/search?q=\nnixos.wiki/index.php?search=\nprotondb.com/search?q="
          search_site="$(echo -e "''${search_options}" | ${menu-program} --prompt-text "Search website")"
          input="$(${menu-program} --prompt-text "Search term")"
          firefox -p default "''${search_site}''${input}"
        '';
      })
      (writeShellApplication {
        name = "show-script";
        text = ''
          ${cat} "$(show-nix-store-path "''${1}")"
        '';
      })
      (writeShellApplication {
        name = "watchlist";
        text = let
          dateSecond = "$(date +%s)";
          watchlistDir = "${config.xdg.userDirs.videos}/watchlist";
        in ''
          [ $# -eq 0 ] && setsid umpv "${watchlistDir}"
          path="''${1%%:*}"
          case "''${path}" in
            http|https) setsid ${getExe yt-dlp} \
              --sponsorblock-mark all\
              --embed-subs\
              --embed-metadata\
              -o "${watchlistDir}/${dateSecond}-%(title)s-[%(id)s].%(ext)s"\
            "''${1}" >>/dev/null & ;;
            *) setsid mv "''${1}" "${watchlistDir}/${dateSecond}-''${1}" ;;
          esac
        '';
      })
      (shellApplicationWithInputs {
        name = "xdg-open";
        text = ''
          case "''${1%%:*}" in
            gemini) ${lagrange}/bin/lagrange "''${1}" ;;
            http|https|*.html) firefox -p default "''${1}" ;;
            magnet|*.torrent)
              transmission-remote -a "''${1}" && ${notify} "Torrent Added! ✅";;
            *.org) emacsclient --create-frame "''${1}" ;;
            *.png|*.jpg|*.jpeg|*.webp) ${imv}/bin/imv "''${1}" ;;
            *.pdf) setsid ${zathura}/bin/zathura "''${1}" ;;
            *) ${xdg-utils}/bin/xdg-open "''${1}" ;;
          esac
        '';
      })
    ]
    ++ shellApplicationFromList [
      "calendarios-gaby"
      "code2png"
      "config-check"
      "gen-ssh-key"
      "generate-months"
      "git-find-deleted-files"
      "git-remove-merged-branches"
      "nvim-clean"
      "regen"
      "remove-whitespace"
      "run-backups"
      "show-nix-store-path"
      "sway-shot"
    ];
}
