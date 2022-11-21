{ pkgs
, config
, lib
, ...
}:
let
  inherit (config.home-manager.users.kiri.xdg) cacheHome;
  inherit (lib) getExe;
  lockCommand = "${getExe pkgs.swaylock} --image ${cacheHome}/background_image -f";
  commonCommands = {
    dmenuCommand = "rofi -show run | ${pkgs.busybox}/bin/xargs swaymsg exec --";
    desktopCommand = "rofi -show drun | ${pkgs.busybox}/bin/xargs swaymsg exec --";
    feedReader = "${getExe pkgs.newsboat}";
    mailClient = "${getExe pkgs.aerc}";
    terminal = "kitty";
    termFileManager = "${getExe pkgs.lf}";
    termMonitor = "${getExe pkgs.bottom}";
    termAudio = "${getExe pkgs.pulsemixer}";
    transmissionClient = "${getExe pkgs.tremc}";
  };
  colors = import ../../colors.nix;
in
{
  imports = [ ./bar ];
  home-manager.users.kiri =
    { config
    , lib
    , ...
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
              ${getExe pkgs.sway-contrib.grimshot} save window - \
                | ${getExe pkgs.pngquant} --strip - \
                | ${getExe pkgs.swappy} -f -
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
            mouse = { };
          };
        };
      };
      services = {
        wlsunset = {
          enable = true;
          latitude = "-20.0";
          longitude = "-80.0";
        };
        swayidle = {
          enable = true;
          events = [
            {
              event = "before-sleep";
              command = "${lockCommand}";
            }
            {
              event = "lock";
              command = "${lockCommand}";
            }
          ];
          timeouts = [
            {
              timeout = 300;
              command = "${lockCommand}";
            }
            {
              timeout = 600;
              command = ''${pkgs.sway}/bin/swaymsg "output * dpms off"'';
              resumeCommand = ''${pkgs.sway}/bin/swaymsg "output * dpms on"'';
            }
          ];
        };
      };
      wayland.windowManager = {
        sway = {
          enable = true;
          config = {
            bars = [ ];
            terminal = "${commonCommands.terminal}";
            menu = "${commonCommands.dmenuCommand}";
            modifier = "Mod4";
            keybindings = with commonCommands; let
              mod = config.wayland.windowManager.sway.config.modifier;
              inherit (config.wayland.windowManager.sway.config) terminal;
              mShift = "${mod}+Shift";
            in
            lib.mkOptionDefault {
              "${mShift}+a" = "exec qpwgraph";
              "${mShift}+d" = "exec ${commonCommands.desktopCommand}";
              "${mShift}+e" = "exec emacsclient --create-frame";
              "${mShift}+f" = "floating toggle";
              "${mShift}+t" = "exec ${terminal} ${transmissionClient}";
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
              "1" = [{ class = "^Element"; }];
              "6" = [{ app_id = "org.remmina.Remmina"; }];
              "9" = [{ class = "^Steam"; }];
            };
            floating.criteria = [
              { title = "Steam - Update News"; }
              { title = "Steam - News"; }
              { title = "Steam - Self Updater"; }
            ];
            startup = [
              { command = "${getExe pkgs.autotiling}"; }
              {
                command = "systemctl --user restart waybar.service";
                always = true;
              }
              { command = "${getExe pkgs.mako}"; }
              { command = "element-desktop"; }
              { command = "${pkgs.transmission}/bin/transmission-daemon"; }
            ];
            input = {
              "*" = {
                xkb_layout = "us,latam";
                xkb_options = "grp:win_space_toggle";
              };
            };
            output = {
              "*" = { bg = "${cacheHome}/background_image fill"; };
              "DP-1" = {
                mode = "1920x1080";
                position = "1920 0";
                adaptive_sync = "on";
              };
              "HDMI-A-1" = {
                mode = "1920x1080";
                position = "0 0";
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
            workspaceOutputAssign =
              let
                inherit (lib.lists) forEach range;
                rightWorkspaces = range 1 5;
                leftWorkspaces = range 6 9;
              in
              forEach leftWorkspaces
                (space: {
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
  xdg = {
    portal = {
      enable = true;
      wlr = { enable = true; };
    };
  };
}
