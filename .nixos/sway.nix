{ config, pkgs, ... }: {
  programs = {
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        brightnessctl
        imv # image viewer
        libnotify # for sending custom notifications
        swayidle # idle monitoring
        swaylock # lockscreen
        qt5.qtwayland # QT compat
        waybar # status bar
        wl-clipboard # clipboard
        wofi # menu
        xwayland # Xorg compat
        mako # notifications
        # screenshots
        grim
        slurp
      ];
      extraSessionCommands = ''
        export SDL_VIDEODRIVER=wayland
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        export _JAVA_AWT_WM_NONREPARENTING=1
      '';
      wrapperFeatures = {
        base = true;
        gtk = true;
      };
    };
    waybar.enable = true;
  };
  services = {
    redshift = {
      enable = true;
      package = pkgs.redshift-wlr;
    };
  };
}
