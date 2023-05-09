{ pkgs
, config
, lib
, ...
}:
let
  inherit (config.home-manager.users.kiri.xdg) cacheHome;
  inherit (lib) getExe fileContents;
  inherit (builtins) replaceStrings;
  inherit (import ../../default-programs.nix { inherit pkgs lib; })
    http-browser
    terminal
    terminal-http-browser
    terminal-feed-reader
    terminal-audio
    terminal-monitor
    terminal-file-manager
    terminal-mail-client;
  lockCommand = "${getExe pkgs.swaylock} --image ${cacheHome}/background_image -f";
  dmenuCommand = "rofi -show run | ${pkgs.busybox}/bin/xargs swaymsg exec --";
  desktopCommand = "rofi -show drun | ${pkgs.busybox}/bin/xargs swaymsg exec --";
  transmissionClient = "${getExe pkgs.tremc}";
  colors = import ../../colors.nix;
in
{
  home-manager.users.kiri =
    { config
    , lib
    , ...
    }: {
      imports = [ ./bar.nix ./notifications.nix ];
      xdg.configFile."electron-flags.conf".text = ''
        --enable-features=UseOzonePlatform
        --ozone-platform=wayland
      '';
      home = {
        packages = with pkgs; [
          wl-clipboard
          (writeShellApplication {
            name = "sway-shot";
            text = replaceStrings [ "grimshot" "pngquant" "swappy" ]
              [
                "${getExe sway-contrib.grimshot}"
                "${getExe pngquant}"
                "${getExe swappy}"
              ] ''
              ${fileContents ../../../scripts/sway-shot.sh}
            '';
          })
        ];
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
          inherit terminal;
            bars = [{
              fonts.size = 10.0;
              statusCommand = "i3status-rs ${config.xdg.configHome}/i3status-rust/config-default.toml";
              position = "top";
            }];
            menu = "${dmenuCommand}";
            modifier = "Mod4";
            keybindings =
              let
                mod = config.wayland.windowManager.sway.config.modifier;
                mShift = "${mod}+Shift";
              in
              lib.mkOptionDefault {
                "${mShift}+a" = "exec qpwgraph";
                "${mShift}+d" = "exec ${desktopCommand}";
                "${mShift}+e" = "exec emacsclient --create-frame";
                "${mShift}+f" = "floating toggle";
                "${mShift}+t" = "exec ${terminal} ${transmissionClient}";
                "${mod}+a" = "exec ${terminal} ${terminal-audio}";
                "${mod}+s" = "exec search";
                "${mod}+e" = "exec ${terminal} ${terminal-mail-client}";
                "${mod}+i" = "exec ${terminal} ${terminal-monitor}";
                "${mod}+n" = "exec ${terminal} ${terminal-feed-reader}";
                "${mod}+r" = "exec ${terminal} ${terminal-file-manager}";
                "${mod}+x" = "exec ${lockCommand}";
                "${mod}+p" = "exec emoji";
                "${mod}+w" = "exec ${http-browser}";
                "${mod}+z" = "exec password-menu show";
                "${mod}+Shift+z" = "exec password-menu otp";
                "Print" = "exec sway-shot";
              };
            assigns = {
              "1" = [{ app_id = "org.remmina.Remmina"; }];
              "6" = [{ class = "^Steam"; } { title = "Steam"; }];
              "9" = [{ app_id = "^Element"; }
                { app_id = "thunderbird"; }];
            };
            floating.criteria = [
              { title = "Friends List"; class = "Steam"; }
              { title = "Steam - Update News"; }
              { title = "Steam - News"; }
              { title = "Steam - Self Updater"; }
            ];
            startup = [
              { command = "${getExe pkgs.autotiling}"; }
              { command = http-browser; }
              { command = "${getExe pkgs.mako}"; }
              { command = "${getExe pkgs.element-desktop-wayland}"; }
              { command = "${getExe pkgs.thunderbird}"; }
              { command = "${getExe pkgs.swww} init"; }
              { command = "${pkgs.transmission}/bin/transmission-daemon"; }
            ];
            input = {
              "*" = {
                xkb_layout = "us,latam";
                xkb_options = "grp:win_space_toggle";
              };
            };
            output = {
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
            window.commands = [{
              command = "kill";
              criteria = {
                app_id = "firefox";
                title = "Firefox — Sharing Indicator";
              };
            }];
            workspaceOutputAssign =
              let
                inherit (lib.lists) forEach range;
                leftWorkspaces = range 1 6;
                rightWorkspaces = range 7 9;
                assignWorkspace = { list, output }: forEach list (space: { output = "${output}"; workspace = "${toString space}"; });
              in
              assignWorkspace { list = leftWorkspaces; output = "DP-1"; }
              ++ assignWorkspace { list = rightWorkspaces; output = "HDMI-A-1"; };
          };
          extraSessionCommands = ''
            export GDK_BACKEND='wayland,x11' \
            MOZ_ENABLE_WAYLAND=1 \
            QT_QPA_PLATFORM=wayland \
            QT_QPA_PLATORMTHEME=qt5ct \
            GTK_USE_PORTAL=1 \
            QT_WAYLAND_DISABLE_WINDOWDECORATION=1 \
            SDL_VIDEODRIVER=wayland \
            XDG_CURRENT_DESKTOP=sway \
            XDG_CURRENT_SESSION_TYPE=wayland \
            XDG_SESSION_DESKTOP=sway \
            XDG_SESSION_TYPE=wayland \
            _JAVA_AWT_WM_NONREPARENTING=1
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
  xdg.portal = {
    enable = true;
    wlr.enable = config.programs.sway.enable;
  };
  programs.hyprland.enable = true;
}
