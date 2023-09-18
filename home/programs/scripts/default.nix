{ pkgs
, lib
, config
, hypr-contrib
, ...
}:
let
  inherit (lib) fileContents;
  inherit (import ../../shell/aliases.nix { inherit pkgs lib; }) cat;
  inherit (config.xdg.userDirs) download;
  inherit (pkgs) writeShellApplication;
  menu-program = "${config.programs.rofi.finalPackage}/bin/rofi -dmenu";
  backupIfDuplicate = ext: ''
    if [ "''${ext}" = "${ext}" ]; then
      bak="''${file}.bak"
      mv "''${file}" "''${bak}"
      file="''${file}.bak"
    fi
  '';
  scriptAudio = "-c:a libopus -b:a 128k";
  process-inputs = ''
    [ $# -eq 0 ] && notify-send "No arguments provided. Exitting..." && exit 1
    file="$(realpath "''${1}")"
    ext=''${file##*.}
    base=''${file%.*}
    directory=''${file%/*}
    export file ext base directory
  '';
in
{
  home.packages = [
    (writeShellApplication {
      name = "2opus";
      runtimeInputs = [ pkgs.ffmpeg pkgs.mediainfo ];
      text = fileContents ./2opus.sh;
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
    (writeShellApplication {
      name = "2webp";
      runtimeInputs = [ pkgs.libwebp ];
      text = ''
        ${process-inputs}
        case "''${ext}" in
        jpg | jpeg ) cwebp -q 80 "''${file}" -o "''${base}.webp" ;;
        png ) cwebp -lossless "''${file}" -o "''${base}.webp" ;;
        webp ) echo "File is already WEBP" && exit 1 ;;
        * ) echo "Can't handle that file extension..." && exit 1 ;;
        esac
      '';
    })
    (writeShellApplication {
      name = "beeper";
      runtimeInputs = [ pkgs.appimage-run ];
      text = "appimage-run ${download}/beeper-3.75.16.AppImage";
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
      runtimeInputs = [ pkgs.yt-dlp ];
      text = ''
        ${process-inputs}
        setsid yt-dlp --sponsorblock-mark all \
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
      name = "error";
      runtimeInputs = [ pkgs.libnotify ];
      text = fileContents ./error.sh;
    })
    (writeShellApplication {
      name = "feed-subscribe";
      text = ''
        if [ $# -eq 0 ]; then
          url="$(${menu-program} --prompt-text Url)"
        else
          url="''${1}"
        fi
        xdg-open "https://reader.miniflux.app/bookmarklet?uri=''${url}"
      '';
    })
    (writeShellApplication {
      name = "generate-months";
      text = fileContents ./generate-months.bash;
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
      name = "git-pushall";
      text = fileContents ./git-pushall.sh;
    })
    (writeShellApplication {
      name = "optisize";
      runtimeInputs = with pkgs; [ ffmpeg file mediainfo mozjpeg ];
      text = ''
        jpeg-optimize() {
          output="$(mktemp)"
          cp "''${file}" "''${output}"
          jpegtran -copy none -optimize -progressive "''${output}" > "''${file}"
        }

        re-encode-video() {
          ${backupIfDuplicate "mkv"}
          temp_out="$(mktemp --suffix=.mkv)"
          ffmpeg -i "''${file}" -c:v "''${video_codec}" -crf 28 -preset slow ${scriptAudio} -y "''${temp_out}"
          mv "''${temp_out}" "''${base}.mkv"
        }

        video-optimize() {
          info="$(mediainfo "''${file}")"
          case "''${info}" in
            *"AVC"*)
              export video_codec=libx265
              re-encode-video
              ;;
            *"VP8"* )
              export video_codec=libvpx-vp9
              re-encode-video
              ;;
            *"HEVC"* | *"AV1"* | *"VP9"* ) echo "File already optimized." ;;
            *)
              echo -e "''${red}I don't know if I can optimize this file...''${reset}"
              exit 1
              ;;
          esac
        }

        red='\033[1;31m ERROR: '
        reset='\033[0m'
        ${process-inputs}
        mimetype="$(file --mime --brief "''${file}")"
        case "''${mimetype}" in
          "image/jpeg"*)
            jpeg-optimize ;;
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
      name = "password-menu";
      runtimeInputs = with pkgs; [ wtype rofi-rbw ];
      text = "rofi-rbw";
    })
    (writeShellApplication {
      name = "regen";
      runtimeInputs = [ pkgs.nvd ];
      text = fileContents ./regen.sh;
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
    (writeShellApplication {
      name = "run-backups";
      runtimeInputs = [ pkgs.borgbackup ];
      text = fileContents ./run-backups.sh;
    })
    (writeShellApplication {
      name = "screenshot";
      runtimeInputs = [
        pkgs.swappy
        hypr-contrib.packages.${pkgs.system}.grimblast
      ];
      text = fileContents ./screenshot.sh;
    })
    (writeShellApplication {
      name = "search";
      text = ''
        search_options="farside.link/whoogle/search?q=\nyoutube.com/results?search_query=\ngithub.com/search?q=\nnixos.wiki/index.php?search=\nprotondb.com/search?q=\nsearch.nixos.org/packages?query="
        search_site="$(echo -e "''${search_options}" | ${menu-program} --prompt-text "Search website")"
        input="https://$(${menu-program} --prompt-text "Search term")"
        xdg-open "''${search_site}''${input}"
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
      runtimeInputs = [ pkgs.ripgrep ];
      text = "rg --files-with-matches equirosa | rg '^pkgs'";
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
    (writeShellApplication {
      name = "xdg-open";
      runtimeInputs = with pkgs; [ imv lagrange zathura libnotify ];
      text = ''
        [ $# -eq 0 ] && notify-send "No arguments provided. Exitting..." && exit 1
        for arg in "$@"; do
          case "''${arg}" in
            magnet* | *.torrent )
              setsid transmission-remote -a "''${arg}" && notify-send -u low "Torrent Added! ✅"
              ;;
            *.org ) setsid emacsclient --create-frame "''${arg}" ;;
            *.png | *.jpg | *.jpeg | *.webp ) setsid imv "''${arg}" ;;
            * ) setsid ${pkgs.xdg-utils}/bin/xdg-open "''${arg}" ;;
          esac
        done
      '';
    })
  ];
}
