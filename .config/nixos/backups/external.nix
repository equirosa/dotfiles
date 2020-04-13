{ config, ... }: {
  services = {
    borgbackup.jobs.external = {
      compression = "auto,lz4";
      doInit = false;
      encryption.mode = "none";
      exclude = [ "*/league-of-legends/*" ];
      extraPruneArgs = "--save-space";
      paths = [
        "/home/eduardo/Documents"
        "/home/eduardo/Pictures"
        "/home/eduardo/Videos"
        "/home/eduardo/projects"
        "/home/eduardo/Games"
        "/home/eduardo/Templates"
        "/home/eduardo/Music"
      ];
      prune.keep = {
        within = "1d";
        daily = 7;
        weekly = 4;
        monthly = -1;
      };
      removableDevice = true;
      repo = "/run/media/eduardo/2e571771-81db-41a5-a0b6-d5c6d3b8bf88/borg";
      startAt = "hourly";
      user = "eduardo";
    };
  };
}
