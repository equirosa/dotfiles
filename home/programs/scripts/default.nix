{ pkgs
, lib
, config
, inputs
, ...
}:
let
  inherit (lib) getExe fileContents;
  inherit (import ../../shell/aliases.nix { inherit pkgs lib; }) cat;
  inherit (config.xdg.userDirs) download;
  inherit (pkgs)
    ffmpeg_6-full
    file
    imv
    lagrange
    libnotify
    mediainfo
    mozjpeg
    pandoc
    remmina
    ripgrep
    rofi-rbw
    tofi
    writeShellApplication
    wtype
    xdg-utils
    yt-dlp
    zathura
    ;
  notify = writeShellApplication {
    name = "notify";
    runtimeInputs = [ libnotify ];
    text = fileContents ./notify.sh;
  };
  menu-program = getExe tofi;
  backupIfDuplicate = ext: ''
    if [ "''${ext}" = "${ext}" ]; then
    bak="''${file}.bak"; mv "''${file}" "''${bak}"
    file="''${file}.bak"
    fi
  '';
  ffmpeg-bin = "${ffmpeg_6-full}/bin/ffmpeg";
  scriptAudio = "-c:a libopus -b:a 128k";
  process-inputs = ''
    [ $# -eq 0 ] && ${notify} "No arguments provided. Exitting..." && exit 1
    file="$(realpath "''${1}")"
    ext=''${file##*.}
    base=''${file%.*}
    directory=''${file%/*}
  '';
in
{
  home.packages = [
    notify
    (writeShellApplication {
      name = "2ogg";
      text = ''
        ${process-inputs}
        ${backupIfDuplicate "ogg"}
        ${ffmpeg-bin} -i "''${file}" -vn ${scriptAudio} "''${base}.ogg"
      '';
    })
    (writeShellApplication {
      name = "2org";
      text = ''
        ${process-inputs}
        case "''${ext}" in
          odt | docx ) ${getExe pandoc} "''${1}" -o "''${file}.org" ;;
          * ) printf "I can't handle that format yet!\n"
        esac
      '';
    })
    (writeShellApplication {
      name = "2pdf";
      runtimeInputs = [ pkgs.libreoffice-fresh ];
      text = ''
        ${process-inputs}
        case "$ext" in
          odt | docx) libreoffice --headless --convert-to pdf "$file" ;;
          *) printf "I can't handle that format yet!\n" ;;
        esac
      '';
    })
    (writeShellApplication {
      name = "2webp";
      runtimeInputs = [ pkgs.libwebp ];
      text = ''
        ${process-inputs}
        case "''${ext}" in
        jpg | jpeg ) cwebp -q 80 "''${file}" -o "''${base}.webp" ;;
        png ) cwebp -lossless "''${file}" -o "''${base}.webp" ;;
        webp ) printf "File is already WEBP" && exit 1 ;;
        * ) printf "Can't handle that file extension..." && exit 1 ;;
        esac
      '';
    })
    (writeShellApplication {
      name = "beeper";
      runtimeInputs = [ pkgs.appimage-run ];
      text = "appimage-run ${download}/beeper-3.67.16.AppImage";
    })
    (writeShellApplication {
      name = "calendarios-gaby";
      text = fileContents ./calendarios-gaby.sh;
    })
    (writeShellApplication {
      name = "code2png";
      runtimeInputs = [ pkgs.silicon ];
      text = fileContents ./code2png.sh;
    })
    (writeShellApplication {
      name = "download-media";
      text = ''
        ${process-inputs}
        setsid ${getExe yt-dlp} --sponsorblock-mark all \
        --embed-subs --embed-metadata \
        -o "%(title)s-[%(id)s].%(ext)s" "$1" >>/dev/null &
      '';
    })
    (writeShellApplication {
      name = "emoji";
      runtimeInputs = [ pkgs.rofimoji ];
      text = fileContents ./emoji.sh;
    })
    (writeShellApplication {
      name = "feed-subscribe";
      text = ''
        if [ $# -eq 0 ]; then
          url="$(${menu-program} --prompt-text Url)"
        else
          url="''${1}"
        fi
        librewolf "https://reader.miniflux.app/bookmarklet?uri=''${url}"
      '';
    })
    (writeShellApplication {
      name = "generate-months";
      text = fileContents ./generate-months.sh;
    })
    (writeShellApplication {
      name = "git-find-deleted-files";
      text = fileContents ./git-find-deleted-files.sh;
    })
    (writeShellApplication {
      name = "git-remove-merged-branches";
      text = fileContents ./git-remove-merged-branches.sh;
    })
    (writeShellApplication {
      name = "optisize";
      text = ''
        jpeg-optimize() {
          output="$(mktemp)"
          cp "''${file}" "''${output}"
          ${mozjpeg}/bin/jpegtran -copy none -optimize -progressive "''${output}" > "''${file}"
        }

        video-optimize() {
          info="$(${getExe mediainfo} "''${file}")"
          case "''${info}" in
            *"AVC"*)
              ${backupIfDuplicate "mkv"}
              ${ffmpeg-bin} -i "''${file}" -vcodec libx265 -crf 28 "''${base}.mkv" ;;
            *"HEVC"* | *"AV1"* ) echo "File already optimized." ;;
            *) echo "I don't know if I can optimize the ''${info} codec..." ;;
          esac
        }

        ${process-inputs}
        mimetype="$(${getExe file} --mime --brief "''${file}")"
        case "''${mimetype}" in
          "image/jpeg"*)
            jpeg-optimize ;;
          "video/"*)
            video-optimize ;;
        * ) echo "I don't know how to handle that file" ;;
        esac
      '';
    })
    (writeShellApplication {
      name = "password-menu";
      runtimeInputs = [ wtype ];
      text = "${getExe rofi-rbw}";
    })
    (writeShellApplication {
      name = "regen";
      runtimeInputs = [ pkgs.nvd ];
      text = fileContents ./regen.sh;
    })
    (writeShellApplication {
      name = "rem-lap";
      text = ''
        chosen=$(find "${config.xdg.dataHome}/remmina/" -name "*.remmina")

        [ "$(wc -l <<< "''${chosen}")" -gt 1 ] &&\
        chosen=$(printf "''${chosen}" | ${menu-program})

        ${getExe remmina} -c "$chosen"
      '';
    })
    (writeShellApplication {
      name = "run-backups";
      runtimeInputs = [ pkgs.borgbackup ];
      text = fileContents ./run-backups.sh;
    })
    (writeShellApplication {
      name = "screenshot";
      runtimeInputs = [
        pkgs.swappy
        inputs.hypr-contrib.packages.${pkgs.system}.grimblast
      ];
      text = fileContents ./screenshot.sh;
    })
    (writeShellApplication {
      name = "search";
      text = ''
        search_options="farside.link/whoogle/search?q=\nyoutube.com/results?search_query=\ngithub.com/search?q=\nnixos.wiki/index.php?search=\nprotondb.com/search?q="
        search_site="$(echo -e "''${search_options}" | ${menu-program} --prompt-text "Search website")"
        input="$(${menu-program} --prompt-text "Search term")"
        librewolf "''${search_site}''${input}"
      '';
    })
    (writeShellApplication {
      name = "show-nix-store-path";
      text = ''realpath "$(command -v "''${1}")"'';
    })
    (writeShellApplication {
      name = "show-script";
      text = ''${cat} "$(show-nix-store-path "''${1}")"'';
    })
    (writeShellApplication {
      name = "my-pkgs";
      runtimeInputs = [ ripgrep ];
      text = "rg --files-with-matches equirosa | rg '^pkgs'";
    })
    (writeShellApplication {
      name = "watchlist";
      text =
        let
          dateSecond = "$(date +%s)";
          watchlistDir = "${config.xdg.userDirs.videos}/watchlist";
        in
        ''
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
    (writeShellApplication {
      name = "xdg-open";
      runtimeInputs = [ imv lagrange xdg-utils zathura ];
      text = ''
        ${process-inputs}
        case "''${1%%:*}" in
          gemini) lagrange "''${1}" ;;
          http|https|*.html) librewolf "''${1}" ;;
          magnet|*.torrent)
            transmission-remote -a "''${1}" && ${notify} "Torrent Added! ✅";;
          *.org) emacsclient --create-frame "''${1}" ;;
          *.png|*.jpg|*.jpeg|*.webp) imv "''${1}" ;;
          *.pdf) setsid zathura "''${1}" ;;
          *) xdg-open "''${1}" ;;
        esac
      '';
    })
  ];
}
