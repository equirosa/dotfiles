{ config, ... }: {
  imports = [
    # Import global configuration
    ../eduardo.nix
    ../window-managers/wayland/sway.nix
    ../virtualization.nix
  ];
  networking = {
    hostName = "frost";
    networkmanager.enable = true;
  };
}
