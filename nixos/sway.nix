{ pkgs, config, ... }:
let
  lockCommand = "${pkgs.swaylock}/bin/swaylock --image ${config.home-manager.users.kiri.xdg.cacheHome}/background_image -f";
  commonCommands = {
    feedReader = "${pkgs.newsboat}/bin/newsboat";
    mailClient = "${pkgs.aerc}/bin/aerc";
    termFileManager = "${pkgs.lf}/bin/lf";
    termMonitor = "${pkgs.bottom}/bin/btm";
    termAudio = "${pkgs.pulsemixer}/bin/pulsemixer";
  };
  colors = import ./colors.nix;
in
{
  home-manager.users.kiri = { config, lib, ... }: {
    # Foot config. TODO: consider moving to own file
    programs = {
      mako = {
        enable = true;
      };
      foot = {
        enable = true;
        server.enable = false;
        settings = {
          colors = with colors; with gruvbox; {
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
          main = {
            bold-text-in-bright = "true";
            font = "monospace:size=14";
          };
          mouse = { };
        };
      };
    };
    wayland.windowManager = {
      sway = {
        enable = true;
        config = {
          terminal = "${pkgs.foot}/bin/foot";
          menu = "${pkgs.bemenu}/bin/bemenu-run | ${pkgs.findutils}/bin/xargs swaymsg exec --";
          modifier = "Mod4";
          keybindings =
            let
              mod = config.wayland.windowManager.sway.config.modifier;
              inherit (config.wayland.windowManager.sway.config) terminal;
            in
            lib.mkOptionDefault {
              "${mod}+Shift+f" = "floating toggle";
              "${mod}+a" = "exec ${terminal} ${commonCommands.termAudio}";
              "${mod}+e" = "exec ${terminal} ${commonCommands.mailClient}";
              "Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy window";
              "${mod}+n" = "exec ${terminal} ${commonCommands.feedReader}";
              "${mod}+i" = "exec ${terminal} ${commonCommands.termMonitor}";
              "${mod}+r" = "exec ${terminal} ${commonCommands.termFileManager}";
              "${mod}+x" = "exec ${lockCommand}";
            };
          assigns = {
            "9" = [
              { class = "^Element"; }
              { class = "^discord"; }
            ];
          };
          startup = [
            { command = "${pkgs.autotiling}/bin/autotiling"; }
            { command = "${pkgs.mako}/bin/mako"; }
            { command = "element-desktop"; }
            { command = ''${pkgs.swayidle}/bin/swayidle -w timeout 300 '${lockCommand}' timeout 600 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"; before-sleep '${lockCommand}''; }
          ];
          input = {
            "*" = {
              xkb_layout = "us,latam";
              xkb_options = "grp:win_space_toggle";
            };
          };
          output = {
            "*" = { bg = "${config.xdg.cacheHome}/background_image fill"; };
            "DP-1" = { mode = "1920x1080"; position = "0 0"; adaptive_sync = "on"; };
            "HDMI-A-1" = { mode = "1920x1080"; position = "1920 0"; };
          };
        };
        extraSessionCommands = ''
          export SDL_VIDEODRIVER=wayland
          export QT_QPA_PLATFORM=wayland
          export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
          export _JAVA_AWT_WM_NONREPARENTING=1
          export MOZ_ENABLE_WAYLAND=1
          export XDG_SESSION_TYPE=wayland
          export XDG_CURRENT_DESKTOP=sway
        '';
        systemdIntegration = true;
        wrapperFeatures.gtk = true;
        xwayland = true;
      };
    };
  };
  # NixOS specific stuff
  programs.sway.enable = true; # Sway doesn't launch if enabled only by Home Manager. TODO: report upstream
  security.pam.services.swaylock = { };
  services = {
    pipewire.enable = true;
  };
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
      ];
      gtkUsePortal = true;
    };
  };
}
