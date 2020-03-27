{ config, pkgs, ... }: {
  hardware.bluretooth.enable = true;
  services.blueman.enable = true;
}
