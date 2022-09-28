{pkgs, ...}: {
  home-manager.users.kiri = {config, ...}: {
    programs.mpv = {
      enable = true;
      defaultProfiles = ["gpu-hq"];
      config = {
        force-window = true;
        save-position-on-quit = "";
        screenshot-directory = "${config.xdg.userDirs.pictures}/screenshots";
        gpu-context = "wayland";
        hwdec = "auto-safe";
        vo = "gpu";
        slang = "en,eng";
        alang = "en,eng";
        ytdl-format = "(bestvideo[height<=1080]+bestaudio)[ext=webm]/bestvideo[height<=1080]+bestaudio/best[height<=1080]/bestvideo+bestaudio/best";
      };
      scripts = with pkgs.mpvScripts; [
        mpv-playlistmanager
        sponsorblock
      ];
    };
  };
}
