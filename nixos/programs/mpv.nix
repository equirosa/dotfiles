{pkgs, ...}: {
  home-manager.users.kiri = {config, ...}: {
    home.packages = [pkgs.mpv];
    xdg.configFile = {
      "mpv.conf" = {
        target = "mpv/mpv.conf";
        text = ''
          force-window=yes
          save-position-on-quit
          # screenshot-directory=${config.xdg.userDirs.pictures}/screenshots # TODO: fix this resolution upstream?
          gpu-context=wayland
          screenshot-directory=/home/kiri/Pictures/screenshots
          slang=en,eng
          ytdl-format='bestvideo[height<=?1080]+bestaudio/best'
        '';
      };
    };
  };
  nixpkgs.overlays = [
    (
      self: super: {
        mpv = super.mpv-with-scripts.override {
          scripts = with self.mpvScripts; [
            mpv-playlistmanager
            sponsorblock
          ];
        };
      }
    )
  ];
}
