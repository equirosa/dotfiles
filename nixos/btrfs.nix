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
        subvolume = "/home";
        extraConfig = ''
          ALLOW_USERS="kiri"
          TIMELINE_CREATE=yes
          TIMELINE_CLEANUP=yes
        '';
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
