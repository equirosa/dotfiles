{ pkgs
, lib
, ...
}:
let
  pdf-reader = "${ pkgs.zathura }/bin/zathura";
  terminal = "${ pkgs.foot }/bin/foot";
  geminiBrowser = "${ pkgs.amfora }/bin/amfora";
  writeDashScript =
    name:
    content:
    (
      pkgs.writeScriptBin
        "${ name }"
        ''
        #!${ pkgs.dash }/bin/dash
        ${ content }
        ''
    );
in
{
  home-manager.users.kiri =
    { config
    , ...
    }:
    {
      home.packages =
        with pkgs;
        [
          # Browsers
          torbrowser
          # Messengers
          aerc
          # Documents
          libreoffice
          pandoc
          tectonic
          # Editor
          neovim
          # File Sharing
          ffsend
          onionshare-gui
          transmission
          tremc
          wormhole-william
          # Nix-specific stuff
          alejandra
          # TODO: determine whether I keep this or nixpkgs-fmt
          cachix
          comma
          nix-update
          nixpkgs-fmt
          nixpkgs-review
          # Utilities
          archiver
          borgbackup
          czkawka
          du-dust
          fd
          gopass
          gopass-jsonapi
          imv
          ripgrep
          tealdeer
          trash-cli
          ytfzf
          # Scripts
          (
            writeDashScript
              "check-modifications"
              ''
              nixos-rebuild build --upgrade && ${ lib.getBin pkgs.nvd }/bin/nvd diff /run/current-system ./result && rm ./result
              ''
          )
          (
            writeShellApplication
              {
                name = "download-file";
                text =
                  ''
                  setsid ${ pkgs.yt-dlp }/bin/yt-dlp --sponsorblock-mark all \
                  --embed-subs --embed-metadata -o "%(title)s-[%(id)s].%(ext)s" "$1" >>/dev/null &
                  '';
              }
          )
          (
            writeShellApplication
              {
                name = "emoji";
                runtimeInputs = with pkgs; [ wl-clipboard wofi ];
                text =
                  ''
                  ${ pkgs.wofi-emoji }/bin/wofi-emoji
                  '';
              }
          )
          (
            writeShellApplication
              {
                name = "join-class";
                text =
                  ''
                  chosen="''$(${ pkgs.wofi }/bin/wofi --show dmenu < ~/links | cut -d ' ' -f2)"
                  [ -z "''${chosen}" ] && exit 1
                  xdg-open "''${chosen}"
                  '';
              }
          )
          (
            writeShellApplication
              {
                name = "nixify";
                text =
                  ''
                  [ -e ./.envrc ] || echo "use nix" > .envrc && direnv allow
                  [ -e shell.nix ] || [ -e default.nix ] \
                    || cp "${ config.home.homeDirectory }/Templates/nixify/$1/shell.nix" shell.nix \
                    || cat > shell.nix << 'EOF'
                  with import <nixpkgs> {};
                  mkShell {
                    nativeBuildInputs = [
                    ];
                  }
                  EOF

                  case "$1" in
                    "node") echo "export \$PATH=\$XDG_DATA_DIR/npm/bin:\$PATH" >> ./.envrc;;
                    *) echo "Using default envrc";;
                  esac

                  ${ config.home.sessionVariables.EDITOR } shell.nix
                  '';
              }
          )
          (
            writeShellApplication
              {
                name = "nixpkgs-info-json";
                text =
                  ''
                  nix-env --query --available --attr-path --json "$@" | ${ pkgs.bat }/bin/bat --language json
                  '';
              }
          )
          /*
             (writeDashScript "rem-lap" ''
           chosen=$(find "${config.xdg.dataHome}/remmina/" -name "*.remmina")
           
           [ "$(${pkgs.coreutils}/bin/printf "$chosen" | ${pkgs.coreutils}/bin/wc -l)" -gt 1 ] &&\
           chosen=$(${pkgs.coreutils}/bin/printf "$chosen" | menu)
           
           ${pkgs.remmina}/bin/remmina -c "$chosen"
           '')
           */
          (
            writeDashScript
              "show-ansi-escapes"
              ''
              for i in 30 31 32 33 34 35 36 37 38; do
              ${ pkgs.coreutils }/bin/printf "\033[0;"$i"m Normal: (0;$i); \033[1;"$i"m Light: (1;$i);\n"
              done
              ''
          )
          (
            writeShellApplication
              {
                name = "show-nix-store-path";
                text =
                  ''
                  ${ pkgs.coreutils }/bin/readlink -f "$(command -v "$@")"
                  '';
              }
          )
          (
            writeDashScript
              "watchlist"
              ''
              case "$1" in
                *http*) setsid ${ pkgs.yt-dlp }/bin/yt-dlp \
                  --sponsorblock-mark all\
                  --embed-subs\
                  --embed-metadata\
                  -o "${ config.home.homeDirectory }/Videos/watchlist/$(date +%s)-%(title)s-[%(id)s].%(ext)s"\
                "$1" >>/dev/null & ;;
                "") setsid ${ pkgs.mpv }/bin/umpv "${ config.home.homeDirectory }/Videos/watchlist/" ;;
                *) setsid mv "$1" "${ config.home.homeDirectory }/Videos/watchlist/$(date +%s)-$1" ;;
              esac
              ''
          )
          (
            writeShellApplication
              {
                name = "xdg-open";
                text =
                  ''
                  case "$1" in
                    gemini* ) ${ terminal } ${ geminiBrowser } "$@" ;;
                    *youtube.com/watch* | *youtu.be/* | *twitch.tv/* | *bitcointv.com/w/* | *peertube.co.uk/w/* | *videos.lukesmith.xyz/w/* | *diode.zone/w/* | *peertube.thenewoil.xyz/videos/watch/* | *share.tube/w/* ) setsid ${
                    mpv
                  }/bin/umpv "$1" & ;;
                    http* ) firefox "$@" ;;
                    *.png | *.jpg | *.jpeg ) ${ pkgs.imv }/bin/imv "$@" ;;
                    *.pdf ) setsid ${ pdf-reader } "$@" ;;
                    * ) ${ pkgs.xdg-utils }/bin/xdg-open "$@" ;;
                  esac
                  '';
              }
          )
        ];
    };
}
