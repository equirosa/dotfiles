{ pkgs
, config
, ...
}: {
  services = {
    beesd.filesystems.home = {
      spec = "/home";
      hashTableSizeMB = 4096;
      verbosity = "crit";
      extraOptions = [ "--loadavg-target" "2.5" ];
    };
    btrbk.instances."btrbk" = {
      onCalendar = "*:0/10";
      settings = {
        snapshot_preserve_min = "2d";
        volume."/" = {
          subvolume = "home";
          snapshot_dir = ".snapshots";
        };
      };
    };
    btrfs.autoScrub = {
      enable = true;
      fileSystems = [ "/" ];
    };
  };
}
