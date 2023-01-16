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
    btrfs.autoScrub = {
      enable = true;
      fileSystems = [ "/" ];
    };
  };
}
