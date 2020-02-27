{ config, pkgs, ... }: {
  home-manager.users.eduardo = { pkgs, ... }: {
    programs.mpv = {
      enable = true;
      config = {
        force-window = "yes";
        ytdl-format = "bestvideo+bestaudio";
        #cache-default = 4000000;
      };
    };
  };
}
