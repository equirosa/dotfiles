{ config, pkgs, ... }: {
  programs = {
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        bemenu
        brightnessctl
        swayidle # idle monitoring
        swaylock-effects # lockscreen
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
    redshift = {
      enable = true;
      package = pkgs.redshift-wlr;
    };
  };
}
