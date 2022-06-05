{
  pkgs,
  config,
  ...
}: let
  lockCommand = "${pkgs.swaylock}/bin/swaylock --image ${config.home-manager.users.kiri.xdg.cacheHome}/background_image -f";
  commonCommands = {
    feedReader = "${pkgs.newsboat}/bin/newsboat";
    mailClient = "${pkgs.aerc}/bin/aerc";
    terminal = "kitty";
    termFileManager = "${pkgs.lf}/bin/lf";
    termMonitor = "${pkgs.bottom}/bin/btm";
    termAudio = "${pkgs.pulsemixer}/bin/pulsemixer";
    transmissionClient = "${pkgs.tremc}/bin/tremc";
  };
  colors = import ../../colors.nix;
in {
  imports = [./bar];
  home-manager.users.kiri = {
    config,
    lib,
    ...
  }: {
    # Foot config. TODO: consider moving to own file
    home = {
      packages = with pkgs; [
        wl-clipboard
        (writeShellApplication {
          name = "sway-shot";
          text = ''
            ${pkgs.grim}/bin/grim -g "$(sway-geometry)" - | ${pkgs.pngquant}/bin/pngquant - | ${pkgs.swappy}/bin/swappy -f -
          '';
        })
        (writeShellApplication {
          name = "sway-geometry";
          text = ''
            swaymsg -t get_tree | ${pkgs.jq}/bin/jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | ${pkgs.slurp}/bin/slurp
          '';
        })
      ];
    };
    programs = {
      mako = {
        enable = true;
        backgroundColor = "#2e3440";
        borderColor = "#88c0d0";
        borderRadius = 15;
        borderSize = 2;
        defaultTimeout = 5000;
        font = "monospace 14";
        height = 110;
        layer = "top"; # Consider overlay
        markup = true;
        sort = "-time";
        extraConfig = ''
          [urgency=low]
          border-color=#cccccc

          [urgency=normal]
          border-color=#d08770

          [urgency=high]
          border-color=#bf616a
          default-timeout=0

          [category=mpd]
          default-timeout=2000
          group-by=category
        '';
      };
      foot = {
        enable = true;
        server.enable = false;
        settings = {
          colors = with colors;
          with gruvbox; {
            alpha = "${opacity}";
            regular0 = "${regular.black}";
            regular1 = "${regular.red}";
            regular2 = "${regular.green}";
            regular3 = "${regular.yellow}";
            regular4 = "${regular.blue}";
            regular5 = "${regular.magenta}";
            regular6 = "${regular.cyan}";
            regular7 = "${regular.white}";
            bright0 = "${bright.black}";
            bright1 = "${bright.red}";
            bright2 = "${bright.green}";
            bright3 = "${bright.yellow}";
            bright4 = "${bright.blue}";
            bright5 = "${bright.magenta}";
            bright6 = "${bright.cyan}";
            bright7 = "${bright.white}";
          };
          key-bindings = {
            scrollback-up-line = "Control+Shift+k";
            scrollback-down-line = "Control+Shift+j";
          };
          main = {
            bold-text-in-bright = "true";
            font = "monospace:size=14";
          };
          mouse = {};
        };
      };
    };
    services = {
      wlsunset = {
        enable = true;
        latitude = "-20.0";
        longitude = "-80.0";
      };
    };
    wayland.windowManager = {
      sway = {
        enable = true;
        config = {
          bars = [];
          terminal = "${commonCommands.terminal}";
          menu = "${pkgs.rofi-wayland}/bin/rofi -show run | ${pkgs.findutils}/bin/xargs swaymsg exec --";
          modifier = "Mod4";
          keybindings = let
            mod = config.wayland.windowManager.sway.config.modifier;
            inherit (config.wayland.windowManager.sway.config) terminal;
          in
            lib.mkOptionDefault
            {
              "${mod}+Shift+e" = "exec emacsclient -c";
              "${mod}+Shift+f" = "floating toggle";
              "${mod}+Shift+t" = "exec ${terminal} ${commonCommands.transmissionClient}";
              "${mod}+a" = "exec ${terminal} ${commonCommands.termAudio}";
              "${mod}+s" = "exec search";
              "${mod}+e" = "exec ${terminal} ${commonCommands.mailClient}";
              "${mod}+i" = "exec ${terminal} ${commonCommands.termMonitor}";
              "${mod}+n" = "exec ${terminal} ${commonCommands.feedReader}";
              "${mod}+r" = "exec ${terminal} ${commonCommands.termFileManager}";
              "${mod}+x" = "exec ${lockCommand}";
              "${mod}+p" = "exec emoji";
              "${mod}+w" = "exec ${config.home.sessionVariables.BROWSER}";
              "${mod}+z" = "exec password-menu show";
              "${mod}+Shift+z" = "exec password-menu otp";
              "Print" = "exec sway-shot";
            };
          assigns = {"9" = [{class = "^Element";}];};
          startup = [
            {command = "${pkgs.autotiling}/bin/autotiling";}
            {command = "${pkgs.mako}/bin/mako";}
            {command = "element-desktop";}
            {command = "${pkgs.transmission}/bin/transmission-daemon";}
          ];
          input = {
            "*" = {
              xkb_layout = "us,latam";
              xkb_options = "grp:win_space_toggle";
            };
          };
          output = {
            "*" = {bg = "${config.xdg.cacheHome}/background_image fill";};
            "DP-1" = {
              mode = "1920x1080";
              position = "0 0";
              adaptive_sync = "on";
            };
            "HDMI-A-1" = {
              mode = "1920x1080";
              position = "1920 0";
            };
          };
          window.commands = [
            {
              command = "kill";
              criteria = {
                app_id = "firefox";
                title = "Firefox — Sharing Indicator";
              };
            }
          ];
        };
        extraSessionCommands = ''
          export GDK_BACKEND="wayland,x11"
          export MOZ_ENABLE_WAYLAND=1
          export QT_QPA_PLATFORM=wayland
          export QT_QPA_PLATORMTHEME=qt5ct
          export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
          export SDL_VIDEODRIVER=wayland
          export XDG_CURRENT_DESKTOP=sway
          export XDG_CURRENT_SESSION_TYPE=wayland
          export XDG_SESSION_DESKTOP=sway
          export XDG_SESSION_TYPE=wayland
          export _JAVA_AWT_WM_NONREPARENTING=1
        '';
        systemdIntegration = true;
        wrapperFeatures.gtk = true;
        xwayland = true;
      };
    };
  };
  # NixOS specific stuff
  programs.sway.enable = true;
  # Sway doesn't launch if enabled only by Home Manager. TODO: report upstream
  services = {pipewire.enable = true;};
  systemd.user = {
    services = {
      swayidle = {
        description = "Idle Manager for Wayland";
        documentation = ["man:swayidle(1)"];
        wantedBy = ["sway-session.target"];
        partOf = ["graphical-session.target"];
        path = [pkgs.bash];
        serviceConfig = {
          ExecStart = ''
            ${pkgs.swayidle}/bin/swayidle -w -d \
            timeout 300 '${lockCommand}' \
            timeout 600 '${pkgs.sway}/bin/swaymsg "output * dpms off"' \
            resume '${pkgs.sway}/bin/swaymsg "output * dpms on"'
          '';
        };
      };
    };
  };
  xdg = {
    portal = {
      enable = true;
      gtkUsePortal = true;
      wlr = {
        enable = true;
      };
    };
  };
}
