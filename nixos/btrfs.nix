{
  pkgs,
  config,
  ...
}: {
  services = {
    beesd.filesystems = {
      root = {
        spec = "/";
        hashTableSizeMB = 1024;
        verbosity = "crit";
        extraOptions = ["--loadavg-target" "2.5"];
      };
    };
    btrfs = {
      autoScrub = {
        enable = true;
        fileSystems = ["/"];
      };
    };
  };
}
