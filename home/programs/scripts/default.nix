{ pkgs
, lib
, config
, ...
}:
let
  inherit (builtins) replaceStrings;
  inherit (lib) getExe optionalString fileContents;
  inherit (import ../../shell/aliases.nix { inherit pkgs lib; }) cat;
  inherit (pkgs)
    coreutils
    ffmpeg_6-full
    file
    imv
    lagrange
    libnotify
    libwebp
    mediainfo
    mozjpeg
    pandoc
    remmina
    ripgrep
    rofi-rbw
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
  menu-program = "rofi -dmenu";
  backupIfDuplicate = ext: ''
    if [ "''${ext}" = "${ext}" ]; then
    bak="''${file}.bak"; mv "''${file}" "''${bak}"
    file="''${file}.bak"
    fi
  '';
  ffmpeg-bin = getExe ffmpeg_6-full;
  scriptAudio = "-c:a libopus -b:a 128k";
  getExeList = map (x: "${getExe pkgs.${x}}");
  stringsToReplace = [
    "appimage-run"
    "libreoffice"
    "nvd"
    "pngquant"
    "rbw"
    "rofimoji"
    "silicon"
    "swappy"
  ];
  shellApplicationFromList =
    map (name: writeShellApplication {
      inherit name;
      text =
        replaceStrings
          stringsToReplace
          (getExeList stringsToReplace)
          "${fileContents ./${name}.sh}";
    });
  shellApplicationWithInputs =
    { name
    , runtimeInputs ? [ ]
    , text
    , getFile ? false || getExt || getBase || getDir
    , getExt ? false
    , getBase ? false
    , getDir ? false
    ,
    }: (writeShellApplication {
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
in
{
  home.packages = [
    notify
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
      text =
        let
          cwebp = "${libwebp}/bin/cwebp";
        in
        ''
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
      name = "feed-subscribe";
      text = ''
        if [ $# -eq 0 ]; then
          url="$(${menu-program} --prompt-text Enter url)"
        else
          url="''${1}"
        fi
        librewolf "https://reader.miniflux.app/bookmarklet?uri=''${url}"
      '';
    })
    (shellApplicationWithInputs {
      name = "optisize";
      getBase = true;
      getExt = true;
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
        librewolf "''${search_site}''${input}"
      '';
    })
    (writeShellApplication {
      name = "show-script";
      text = ''${cat} "$(show-nix-store-path "''${1}")"'';
    })
    (writeShellApplication {
      name = "my-pkgs";
      runtimeInputs = [ ripgrep ];
      text = ''
        rg --files-with-matches equirosa | rg '^pkgs'
      '';
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
    (shellApplicationWithInputs {
      name = "xdg-open";
      text = ''
        case "''${1%%:*}" in
          gemini) ${getExe lagrange} "''${1}" ;;
          http|https|*.html) librewolf "''${1}" ;;
          magnet|*.torrent)
            transmission-remote -a "''${1}" && ${notify} "Torrent Added! ✅";;
          *.org) emacsclient --create-frame "''${1}" ;;
          *.png|*.jpg|*.jpeg|*.webp) ${getExe imv} "''${1}" ;;
          *.pdf) setsid ${getExe zathura} "''${1}" ;;
          *) ${xdg-utils}/bin/xdg-open "''${1}" ;;
        esac
      '';
    })
  ]
  ++ shellApplicationFromList [
    "2pdf"
    "autostart"
    "beeper"
    "calendarios-gaby"
    "code2png"
    "emoji"
    "gen-ssh-key"
    "generate-months"
    "git-find-deleted-files"
    "git-remove-merged-branches"
    "regen"
    "remove-whitespace"
    "run-backups"
    "screenshot"
    "show-nix-store-path"
  ];
}
