{ config, lib, ... }: {
  services = {
    borgbackup.jobs =
      let
        paths = "/home/kiri/";
        common-excludes = map (x: paths + "*/" + x) [
          # Largest cache dirs
          ".cache"
          "cache2" # firefox
          "Cache"
          ".config/Slack/logs"
          ".config/Code/CachedData"
          ".container-diff"
          ".npm/_cacache"
          # Work related dirs
          "node_modules"
          "bower_components"
          "_build"
          ".tox"
          "venv"
          ".venv"
          ".direnv"
          ".stfolder"
          ".local/share/Steam"
          ".steam"
          ".var"
          "rocket-league"
          "rocketleague"
          ".m2"
          "torrented"
          "unhidden"
          ".thumbnails"
          "legendary"
        ];
        games-excludes = map (dir: paths + "Games/" + dir) [
          "battlenet"
          "epic"
          "rocket-league"
        ];
        common-includes = map (dir: paths + dir) [
          "Documents/"
          "Downloads/"
          "Games/itch/"
          "Music/"
          "Sync/"
          "Templates/"
          "Videos/"
          "dotfiles/"
          "projects/"
        ];
        basicBorgJob = name: {
          inherit paths;
          environment = {
            BORG_UNKNOWN_UNENCRYPTED_REPO_ACCESS_IS_OK = "yes";
            BORG_RSH = "ssh -i /home/kiri/.ssh/id_ed25519";
          };
          exclude = common-excludes ++ games-excludes;
          extraCreateArgs = "--verbose --stats --checkpoint-interval 600";
          extraPruneArgs = "--save-space";
          compression = "auto,zstd,10";
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
        inherit (lib) recursiveUpdate;
      in
      {
        snowfortBorgbase = recursiveUpdate
          (basicBorgJob "snowfort")
          {
            encryption = {
              mode = "keyfile";
              passCommand = "cat /home/kiri/.borg_pass";
            };
            repo = "hvwib450@hvwib450.repo.borgbase.com:repo";
          };
        snowfortExternalDrive = recursiveUpdate
          (basicBorgJob "snowfort")
          {
            encryption.mode = "none";
            removableDevice = true;
            repo = "/run/media/kiri/2e571771-81db-41a5-a0b6-d5c6d3b8bf88/borg/";
          };
      };
  };
}
