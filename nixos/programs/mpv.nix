{ pkgs, ... }: {
  home-manager.users.kiri = { config, ... }: {
    home.packages = [
      pkgs.mpv
    ];
    xdg.configFile = {
      "mpv.conf" = {
        target = "mpv/mpv.conf";
        text = ''
          force-window=yes
          save-position-on-quit
          screenshot-directory=${config.xdg.userDirs.pictures}/screenshots
          slang=en,eng
          ytdl-format='bestvideo[height<=?1080]+bestaudio/best'
        '';
      };
    };
  };
  nixpkgs.overlays = [
    (self: super: {
      mpv = super.mpv-with-scripts.override {
        scripts = [
          self.mpvScripts.sponsorblock
          self.mpvScripts.mpv-playlistmanager
        ];
      };
    })
  ];
}
