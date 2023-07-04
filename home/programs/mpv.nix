{ config
, pkgs
, ...
}: {
  programs.mpv = {
    enable = true;
    defaultProfiles = [ "gpu-hq" ];
    config = {
      force-window = true;
      save-position-on-quit = "";
      screenshot-directory = "${config.xdg.userDirs.pictures}/screenshots";
      screenshot-format = "png";
      gpu-context = "wayland";
      hwdec = "auto-safe";
      vo = "gpu";
      osc = true;
      slang = "en,eng";
      alang = "en,eng";
      ytdl-format = "(bestvideo[height<=1080]+bestaudio)[ext=webm]/bestvideo[height<=1080]+bestaudio/best[height<=1080]/bestvideo+bestaudio/best";
    };
    profiles =
      let
        webProtocol = {
          profile-desc = "Profile for web videos";
          speed = 3.14;
          keep-open = "";
          ytdl-format = "(bestvideo[height<=720]+bestaudio)[ext=webm]/bestvideo[height<=720]+bestaudio/best[height<=720]/bestvideo+bestaudio/best";
        };
      in
      {
        "protocol.https" = webProtocol;
        "protocol.http" = webProtocol;
        "extension.gif" = {
          osc = "no";
          loop-file = "";
        };
      };
    scripts = with pkgs.mpvScripts; [
      mpv-playlistmanager
      sponsorblock
    ];
  };
}
