{ config, pkgs, ... }: {
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  programs = {
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        bemenu
        brightnessctl
        swayidle # idle monitoring
        swaylock-effects # lockscreen
        qt5.qtwayland # QT compat
        i3status-rust # status bar
        wf-recorder # screen video capture
        wl-clipboard # clipboard
        wofi # menu
        xwayland # Xorg compat
        mako # notifications
        libappindicator
        # screenshots
        sway-contrib.grimshot
        grim
        slurp
      ];
      extraSessionCommands = ''
        export XDG_SESSION_TYPE=wayland
        export XDG_CURRENT_DESKTOP=Unity
        export SDL_VIDEODRIVER=wayland
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        export _JAVA_AWT_WM_NONREPARENTING=1
        export LOCK_CMD="swaylock-fancy -p"
      '';
      wrapperFeatures = {
        base = true;
        gtk = true;
      };
    };
    waybar.enable = true;
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
