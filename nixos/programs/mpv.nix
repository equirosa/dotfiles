{pkgs, ...}: {
  home-manager.users.kiri = {config, ...}: {
    home.packages = [
      (pkgs.wrapMpv
        (pkgs.mpv-unwrapped)
        {
          scripts = with pkgs.mpvScripts; [
            mpv-playlistmanager
            sponsorblock
          ];
        })
    ];
    xdg.configFile = {
      "mpv.conf" = {
        target = "mpv/mpv.conf";
        text = ''
          force-window=yes
          save-position-on-quit
          screenshot-directory=${config.xdg.userDirs.pictures}/screenshots
          gpu-context=wayland
          hwdec=auto-safe
          vo=gpu
          profile=gpu-hq
          slang=en,eng
          ytdl-format='(bestvideo[height<=1080]+bestaudio)[ext=webm]/bestvideo[height<=1080]+bestaudio/best[height<=1080]/bestvideo+bestaudio/best'
        '';
      };
    };
  };
}
