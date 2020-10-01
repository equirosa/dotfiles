{ config, pkgs, ... }: {
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  programs = {
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu-wayland # launcher
        brightnessctl
        swayidle # idle monitoring
        swaylock-effects # lockscreen
        qt5.qtwayland # QT compat
        i3status-rust # status bar
        wf-recorder # screen video capture
        wl-clipboard # clipboard
        xwayland # Xorg compat
        mako # notifications
        libappindicator # for interaction with notification daemon
        # screenshots
        sway-contrib.grimshot # screenshot utility
        slurp # define screen geometry
        v4l-utils # for screen sharing
      ];
      extraSessionCommands = ''
        export XDG_SESSION_TYPE=wayland
        export XDG_CURRENT_DESKTOP=Unity
        export SDL_VIDEODRIVER=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export _JAVA_AWT_WM_NONREPARENTING=1
        export LOCK_CMD="swaylock-fancy -p"
      '';
      wrapperFeatures = {
        base = true;
        gtk = true;
      };
    };
  };
  services = {
    pipewire.enable = true;
    redshift = {
      enable = true;
      package = pkgs.redshift-wlr;
    };
  };
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
}
