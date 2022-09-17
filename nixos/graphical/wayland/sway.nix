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
    xdg.configFile."electron-flags.conf" = {
      text = ''
        --enable-features=UseOzonePlatform
        --ozone-platform=wayland
      '';
    };
    home = {
      packages = with pkgs; [
        wl-clipboard
        (writeShellApplication {
          name = "sway-shot";
          text = ''
            ${pkgs.sway-contrib.grimshot}/bin/grimshot save window - | ${pkgs.pngquant}/bin/pngquant --strip - | ${pkgs.swappy}/bin/swappy -f -
          '';
        })
      ];
    };
    programs = {
      mako = {
        enable = true;
        backgroundColor = "#${colors.selected.background}";
        borderColor = "#${colors.selected.bright.yellow}";
        borderRadius = 15;
        borderSize = 2;
        defaultTimeout = 5000;
        font = "monospace 14";
        height = 110;
        layer = "top"; # Consider overlay
        markup = true;
        sort = "-time";
        extraConfig = with colors.selected.bright; ''
          [urgency=low]
          border-color=#${green}

          [urgency=normal]
          border-color=#${yellow}

          [urgency=high]
          border-color=#${red}
          default-timeout=0

          [category=mpd]
          border-color=#${blue}
          default-timeout=2000
          group-by=category
        '';
      };
      # Foot config. TODO: consider moving to own file
      foot = {
        enable = true;
        server.enable = false;
        settings = {
          colors = with colors;
          with selected; {
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
          keybindings = with commonCommands; let
            mod = config.wayland.windowManager.sway.config.modifier;
            inherit (config.wayland.windowManager.sway.config) terminal;
          in
            lib.mkOptionDefault {
              "${mod}+Shift+e" = "exec emacsclient --create-frame";
              "${mod}+Shift+f" = "floating toggle";
              "${mod}+Shift+t" = "exec ${terminal} ${transmissionClient}";
              "${mod}+a" = "exec ${terminal} ${termAudio}";
              "${mod}+s" = "exec search";
              "${mod}+e" = "exec ${terminal} ${mailClient}";
              "${mod}+i" = "exec ${terminal} ${termMonitor}";
              "${mod}+n" = "exec ${terminal} ${feedReader}";
              "${mod}+r" = "exec ${terminal} ${termFileManager}";
              "${mod}+x" = "exec ${lockCommand}";
              "${mod}+p" = "exec emoji";
              "${mod}+w" = "exec ${config.home.sessionVariables.BROWSER}";
              "${mod}+z" = "exec password-menu show";
              "${mod}+Shift+z" = "exec password-menu otp";
              "Print" = "exec sway-shot";
            };
          assigns = {
            "1" = [{app_id = "org.remmina.Remmina";}];
            "9" = [{class = "^Element";}];
          };
          startup = [
            {command = "${pkgs.autotiling}/bin/autotiling";}
            {
              command = "systemctl --user restart waybar.service";
              always = true;
            }
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
          workspaceOutputAssign = let
            inherit (lib.lists) forEach range;
            leftWorkspaces = range 1 5;
            rightWorkspaces = range 6 9;
          in
            forEach leftWorkspaces (space: {
              output = "DP-1";
              workspace = "${toString space}";
            })
            ++ forEach rightWorkspaces (space: {
              output = "HDMI-A-1";
              workspace = "${toString space}";
            });
        };
        extraSessionCommands = ''
          export GDK_BACKEND="wayland,x11"
          export MOZ_ENABLE_WAYLAND=1
          export QT_QPA_PLATFORM=wayland
          export QT_QPA_PLATORMTHEME=qt5ct
          export GTK_USE_PORTAL=1
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
  # Sway doesn't launch if enabled only by Home Manager. TODO: report upstream
  programs.sway.enable = true;
  services = {
    pipewire.enable = true;
    greetd = {
      enable = true;
      settings = {default_session = {command = "${pkgs.greetd.greetd}/bin/agreety --cmd sway";};};
    };
  };
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
      wlr = {enable = true;};
    };
  };
}
