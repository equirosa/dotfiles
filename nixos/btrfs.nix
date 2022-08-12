{
  pkgs,
  config,
  ...
}: {
  services = {
    beesd.filesystems = {
      root = {
        spec = "/";
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
