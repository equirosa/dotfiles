{pkgs, ...}: {
  home-manager.users.kiri = {config, ...}: {
    programs.mpv = {
      enable = true;
      defaultProfiles = ["gpu-hq"];
      config = {
        force-window = true;
        ytdl-format = "'(bestvideo[height<=1080]+bestaudio)[ext=webm]/bestvideo[height<=1080]+bestaudio/best[height<=1080]/bestvideo+bestaudio/best'";
        screenshot-directory = "${config.xdg.userDirs.pictures}/screenshots";
        gpu-context = "wayland";
        vo = "gpu";
        hwdec = "auto-safe";
        slang = "en,eng";
      };
      scripts = with pkgs.mpvScripts; [
        mpv-playlistmanager
        sponsorblock
      ];
    };
  };
}
