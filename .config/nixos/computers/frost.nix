{ config, ... }: {
  imports = [
    # Import global configuration
    ../global.nix
    ../window-managers/wayland/sway.nix
    ../virtualization.nix
  ];
  networking = {
    hostName = "frost";
    networkmanager.enable = true;
  };
}
