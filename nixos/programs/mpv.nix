{ pkgs, ... }: {
  home-manager.users.kiri = { config, ... }: {
    programs.mpv = {
      enable = true;
      defaultProfiles = [ "gpu-hq" ];
      config = {
        force-window = true;
        save-position-on-quit = "";
        screenshot-directory = "${config.xdg.userDirs.pictures}/screenshots";
        gpu-context = "wayland";
        hwdec = "auto-safe";
        vo = "gpu";
        osc = true;
        slang = "en,eng";
        alang = "en,eng";
        ytdl-format = "(bestvideo[height<=1080]+bestaudio)[ext=webm]/bestvideo[height<=1080]+bestaudio/best[height<=1080]/bestvideo+bestaudio/best";
      };
      profiles = {
        "protocol.https" = {
          profile-desc = "Profile for web videos";
          speed = 3.14;
          keep-open = "";
        };
        "protocol.http".profile = "protocol.https";
      };
      scripts = with pkgs.mpvScripts; [
        mpv-playlistmanager
        sponsorblock
      ];
    };
  };
}
