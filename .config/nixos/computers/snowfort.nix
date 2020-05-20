{ config, pkgs, ... }: {
  imports = [ ../global.nix ];
  networking = { hostName = "snowfort"; };
  services = {
    btrfs.autoScrub = {
      enable = true;
      fileSystems = [ "/home" ];
    };
  };
}
