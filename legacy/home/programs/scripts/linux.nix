{ pkgs
, lib
, config
, ...
}:
let
  inherit (lib) fileContents;
  inherit (pkgs) writeShellApplication;
  menu-program = "${config.programs.rofi.finalPackage}/bin/rofi -dmenu";
  backupIfDuplicate = ext: ''
    if [ "''${ext}" = "${ext}" ]; then
      bak="''${file}.bak"
      mv "''${file}" "''${bak}"
      file="''${file}.bak"
    fi
  '';
  process-inputs = ''
    [ $# -eq 0 ] && notify-send "No arguments provided. Exitting..." && exit 1
    file="$(realpath "''${1}")"
    ext=''${file##*.}
    base=''${file%.*}
    directory=''${file%/*}
    export file ext base directory
  '';
  writeShellApplicationFromFile = { name, runtimeInputs ? [ ] }: writeShellApplication rec {
    inherit name runtimeInputs;
    text = fileContents ./${name}.sh;
  };
in
{
  imports = [ ./default.nix ];
  home.packages = [
    (writeShellApplicationFromFile {
      name = "2opus";
      runtimeInputs = [ pkgs.ffmpeg pkgs.mediainfo ];
    })
    (writeShellApplication {
      name = "2org";
      runtimeInputs = [ pkgs.pandoc ];
      text = ''
        ${process-inputs}
        case "''${ext}" in
          odt | docx ) pandoc "''${1}" -o "''${file}.org" ;;
          * ) echo "I can't handle that format yet!"
        esac
      '';
    })
    (writeShellApplication {
      name = "2pdf";
      runtimeInputs = [ pkgs.unoconv ];
      text = ''
        ${process-inputs}
        case "$ext" in
          odt | docx | doc ) unoconv -f pdf "$file" ;;
          *) echo "I can't handle that format yet!" ;;
        esac
      '';
    })
    (writeShellApplicationFromFile {
      name = "calendarios-gaby";
      runtimeInputs = [ pkgs.aria pkgs.parallel-full ];
    })
    (writeShellApplicationFromFile {
      name = "code2png";
      runtimeInputs = [ pkgs.silicon ];
    })
    (writeShellApplication {
      name = "download-media";
      runtimeInputs = [ pkgs.yt-dlp ];
      text = ''
        ${process-inputs}
        setsid yt-dlp --sponsorblock-mark all \
        --embed-subs --embed-metadata \
        -o "%(title)s-[%(id)s].%(ext)s" "$1" >>/dev/null &
      '';
    })
    (writeShellApplicationFromFile {
      name = "elm-size-comparison";
      runtimeInputs = with pkgs; [ elmPackages.elm nodePackages.uglify-js ];
    })
    (writeShellApplicationFromFile {
      name = "emoji";
      runtimeInputs = [ pkgs.rofimoji ];
    })
    (writeShellApplicationFromFile {
      name = "error";
      runtimeInputs = [ pkgs.libnotify ];
    })
    (writeShellApplication {
      name = "feed-subscribe";
      text = ''
        if [ $# -eq 0 ]; then
          url=""
        else
          url="''${1}"
        fi
        xdg-open "https://reader.miniflux.app/bookmarklet?uri=''${url}"
      '';
    })
    (writeShellApplication rec {
      name = "generate-months";
      text = fileContents ./${name}.bash;
    })
    (writeShellApplicationFromFile {
      name = "git-find-deleted-files";
    })
    (writeShellApplicationFromFile {
      name = "git-remove-merged-branches";
    })
    (writeShellApplication {
      name = "optisize";
      runtimeInputs = with pkgs; [ file handbrake libwebp mediainfo mozjpeg ];
      text = ''
        blue='\033[1;34m INFO: '
        red='\033[1;31m ERROR: '
        reset='\033[0m'

        jpeg-optimize() {
          output="$(mktemp)"
          cp "''${file}" "''${output}"
          jpegtran -copy none -optimize -progressive "''${file}" > "''${output}"
          mv "''${output}" "''${base}-optimized.jpg"
        }

        re-encode-video() {
          ${backupIfDuplicate "mkv"}
          temp_out="$(mktemp --suffix=.mkv)"
          HandBrakeCLI --preset "''${preset}" -i "''${file}" -o "''${temp_out}"
          mv "''${temp_out}" "''${base}.mkv"
        }

        video-optimize() {
          info="$(mediainfo "''${file}")"
          case "''${info}" in
            *"AVC"* | *"VP8"* | *"VP9"* )
              echo -e "''${blue}Old codecs detected detected, converting to AV1...''${reset}"
              export preset="AV1 MKV 2160p60 4K"
              re-encode-video
              ;;
            *"HEVC"* | *"AV1"* ) echo "File already optimized." ;;
            *)
              echo -e "''${red}I don't know if I can optimize this file...''${reset}"
              exit 1
              ;;
          esac
        }

        ${process-inputs}
        mimetype="$(file --mime-type --brief "''${file}")"
        case "''${mimetype}" in
          image/jpeg)
            jpeg-optimize ;;
          image/png)
            printf "%sConverting PNG to WEBP losslessly%s\n" "$blue" "$reset"
            cwebp -lossless "''${file}" -o "''${base}.webp"
            ;;
          "video/"*)
            video-optimize ;;
        * )
          echo -e "''${red}I don't know how to handle that file''${reset}"
          exit 1
          ;;
        esac
      '';
    })
    (writeShellApplication {
      name = "rem-lap";
      runtimeInputs = [ pkgs.remmina ];
      text = ''
        chosen=$(find "${config.xdg.dataHome}/remmina/" -name "*.remmina")

        [ "$(wc -l <<< "''${chosen}")" -gt 1 ] &&\
        chosen=$(echo "''${chosen}" | ${menu-program})

        remmina -c "$chosen"
      '';
    })
    (writeShellApplicationFromFile {
      name = "screenshot";
      runtimeInputs = with pkgs; [ swappy grimblast ];
    })
    (writeShellApplication {
      name = "mirror-phone";
      runtimeInputs = [ pkgs.scrcpy ];
      text = ''
        pgrep scrcpy && pkill scrcpy
        scrcpy --turn-screen-off --stay-awake
      '';
    })
    (writeShellApplication {
      name = "my-pkgs";
      runtimeInputs = [ pkgs.ripgrep ];
      text = "rg --type nix --files-with-matches equirosa pkgs/";
    })
    (writeShellApplication {
      name = "search";
      text = fileContents ./search.bash;
    })
    (writeShellApplication {
      name = "watchlist";
      runtimeInputs = [ pkgs.yt-dlp ];
      text =
        let
          dateSecond = "$(date +%s)";
          watchlistDir = "${config.xdg.userDirs.videos}/watchlist";
        in
        ''
          [ $# -eq 0 ] && setsid umpv "${watchlistDir}"
          path="''${1%%:*}"
          case "''${path}" in
            http|https) setsid yt-dlp \
              --sponsorblock-mark all\
              --embed-subs\
              --embed-metadata\
              -o "${watchlistDir}/${dateSecond}-%(title)s-[%(id)s].%(ext)s"\
            "''${1}" >>/dev/null & ;;
            *) setsid mv "''${1}" "${watchlistDir}/${dateSecond}-''${1}" ;;
          esac
        '';
    })
    (writeShellApplicationFromFile {
      name = "xdg-open";
      runtimeInputs = with pkgs; [ file imv lagrange zathura libnotify xdg-utils ];
    })
  ];
}
