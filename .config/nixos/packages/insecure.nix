{ config, ... }: {
  nixpkgs.config.permittedInsecurePackages = [
    "p7zip-16.02" # Allowed for Lutris
  ];
}
