{
  services = {
    beesd.filesystems.home = {
      spec = "/home";
      hashTableSizeMB = 4096;
      verbosity = "crit";
      extraOptions = [ "--loadavg-target" "2.0" "--workaround-btrfs-send" ];
    };
    snapper = {
      configs.home = {
        SUBVOLUME = "/home";
        ALLOW_USERS = [ "kiri" ];
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
      };
      cleanupInterval = "2d";
      snapshotInterval = "*:0/10";
    };
    btrfs.autoScrub = {
      enable = true;
      fileSystems = [ "/" ];
    };
  };
}
