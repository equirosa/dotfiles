{ config, ... }: {
  imports = [
    # Import global configuration
    ../eduardo.nix
    ../virtualization.nix
  ];
  networking = {
    hostName = "frost";
    networkmanager.enable = true;
  };
}
