_: {
  services = {
    beesd.filesystems.home = {
      spec = "/home";
      hashTableSizeMB = 4096;
      verbosity = "crit";
      extraOptions = [ "--loadavg-target" "2.0" ];
    };
    snapper = {
      configs.home = {
        SUBVOLUME = "/home";
        ALLOW_USERS = [ "kiri" ];
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
      };
      cleanupInterval = "7d";
      snapshotInterval = "*:0/10";
    };
    btrfs.autoScrub = {
      enable = true;
      fileSystems = [ "/" ];
    };
  };
}
