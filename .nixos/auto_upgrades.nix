{ config, pkgs, ... }: {
  system.autoUpgrade = {
    enable = true;
    dates = "0/4:*:*";
  };
}
