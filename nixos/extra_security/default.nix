{ pkgs
, lib
, ...
}: {
  imports = [
    # <nixpkgs/nixos/modules/profiles/hardened.nix>
    ./sudo.nix
  ];
  environment = {
    # Remove default packages to reduce attack surface.
    defaultPackages = lib.mkForce [ ];
    # memoryAllocator.provider = "graphene-hardened"; # TODO: consider using this one, after a successful boot with scudo.
  };
  networking = {
    firewall =
      let
        openPortRanges = [ ];
        open-ports = [ ];
      in
      {
        # Close firewall
        enable = true;
        allowedTCPPorts = open-ports;
        allowedTCPPortRanges = openPortRanges;
        allowedUDPPorts = open-ports;
        allowedUDPPortRanges = openPortRanges;
      };
  };
  nix.settings.allowed-users = [ "@wheel" ];
  # TODO: consider not using electron so I don't have to enable this.
  /*
    security = {
    chromiumSuidSandbox.enable = true;
    unprivilegedUsernsClone = true;
    };
    services = {
    clamav = {
    daemon.enable = true;
    updater.enable = true;
    };
    };
  */
}
