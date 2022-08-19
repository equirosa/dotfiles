{ config, ... }: {
  services = {
    borgbackup.jobs =
      let
        common-excludes = [
          # Largest cache dirs
          ".cache"
          "*/.cache"
          "*/cache2" # firefox
          "*/Cache"
          ".config/Slack/logs"
          ".config/Code/CachedData"
          ".container-diff"
          ".npm/_cacache"
          # Work related dirs
          "*/node_modules"
          "*/bower_components"
          "*/_build"
          "*/.tox"
          "*/venv"
          "*/.venv"
          "*/.direnv"
          "*/.stfolder"
          ".local/share/Steam"
          ".steam"
          ".var"
          "*/rocket-league"
          "*/rocketleague"
          ".m2"
          "*/torrented"
          "*/unhidden"
          "*/.thumbnails"
        ];
        games-excludes = [
          "battlenet"
          "epic"
          "rocket-league"
        ];
        common-includes = [
          "/home/kiri/Documents/"
          "/home/kiri/Downloads/"
          "/home/kiri/Games/itch/"
          "/home/kiri/Music/"
          "/home/kiri/Sync/"
          "/home/kiri/Templates/"
          "/home/kiri/Videos/"
          "/home/kiri/dotfiles/"
          "/home/kiri/projects/"
        ];
        basicBorgJob = name: {
          environment = {
            BORG_UNKNOWN_UNENCRYPTED_REPO_ACCESS_IS_OK = "yes";
            BORG_RSH = "ssh -i /home/kiri/.ssh/id_ed25519";
          };
          extraCreateArgs = "--verbose --stats --checkpoint-interval 600";
          extraPruneArgs = "--save-space";
          compression = "auto,zstd,8";
          doInit = false;
          startAt = "0/6:0:0";
          user = "kiri";
          persistentTimer = true;
          prune.keep = {
            within = "1d";
            daily = 7;
            weekly = 4;
            monthly = -1;
          };
        };
      in
      {
        snowfortBorgbase =
          basicBorgJob "snowfort"
          // rec {
            paths = "/home/kiri/";
            exclude = map (x: paths + x) common-excludes ++ map (dir: paths + "Games/" + dir) games-excludes;
            encryption = {
              mode = "keyfile";
              passCommand = "cat /home/kiri/.borg_pass";
            };
            repo = "hvwib450@hvwib450.repo.borgbase.com:repo";
          };
        snowfortExternalDrive =
          basicBorgJob "snowfort"
          // rec {
            paths = "/home/kiri/";
            exclude = map (x: paths + x) common-excludes ++ map (dir: paths + "Games/" + dir) games-excludes;
            encryption = { mode = "none"; };
            removableDevice = true;
            repo = "/run/media/kiri/2e571771-81db-41a5-a0b6-d5c6d3b8bf88/borg/";
          };
      };
  };
}
