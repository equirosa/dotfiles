{ config, ... }: {
  services = {
    borgbackup.jobs =
      let
        homeDir = "/home/kiri/";
        common-excludes = map (x: homeDir + "*/" + x) [
          # Largest cache dirs
          ".cache"
          ".config"
          ".container-diff"
          ".npm"
          "Cache"
          "cache2" # firefox
          # Work related dirs
          ".direnv"
          ".local/share/Steam"
          ".m2"
          ".steam"
          ".stfolder"
          ".stversions"
          ".thumbnails"
          ".tox"
          ".var"
          ".venv"
          "_build"
          "bower_components"
          "legendary"
          "node_modules"
          "rocket-league"
          "rocketleague"
          "torrented"
          "unhidden"
          "plain"
          "venv"
        ];
        games-excludes = map (dir: "Games/" + dir) [
          "battlenet"
          "epic"
          "rocket-league"
        ];
        common-includes = map (dir: homeDir + dir) [
          "Desktop/"
          "Documents/"
          "Downloads/"
          "Games/itch/"
          "Music/"
          "Sync/"
          "Templates/"
          "Videos/"
          "projects/"
        ];
      in
      {
        snowfortBorgbase = {
          paths = common-includes;
          environment = {
            BORG_UNKNOWN_UNENCRYPTED_REPO_ACCESS_IS_OK = "yes";
            BORG_RSH = "ssh -i /home/kiri/.ssh/id_ed25519";
          };
          exclude = common-excludes ++ games-excludes;
          extraCreateArgs = "--verbose --stats --checkpoint-interval 600";
          extraPruneArgs = "--save-space";
          compression = "auto,zstd,10";
          doInit = false;
          startAt = "hourly";
          user = "kiri";
          persistentTimer = true;
          prune.keep = {
            within = "1d";
            daily = 7;
            weekly = 4;
            monthly = -1;
          };
          encryption = {
            mode = "keyfile";
            passCommand = config.age.secrets.borgbackup-snowfort.path;
          };
          repo = "hvwib450@hvwib450.repo.borgbase.com:repo";
        };
      };
  };
}
