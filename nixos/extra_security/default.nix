{
  pkgs,
  lib,
  ...
}: let
  openPortRanges = [];
  open-ports = [];
in {
  imports = [
    # <nixpkgs/nixos/modules/profiles/hardened.nix>
    ./kernel.nix
    ./sudo.nix
  ];
  environment = {
    # Remove default packages to reduce attack surface.
    defaultPackages = lib.mkForce [];
  };
  networking.firewall = {
    # Close firewall
    enable = true;
    allowedTCPPorts = open-ports;
    allowedTCPPortRanges = openPortRanges;
    allowedUDPPorts = open-ports;
    allowedUDPPortRanges = openPortRanges;
  };
  nix.settings.allowed-users = ["@wheel"];
  security = {
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
    };
  };
}
