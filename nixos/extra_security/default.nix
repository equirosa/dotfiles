{ pkgs, lib, ... }: {
  imports = [
    # <nixpkgs/nixos/modules/profiles/hardened.nix>
    ./firejail.nix
  ];
  environment = {
    defaultPackages = lib.mkForce [ ]; # Remove default packages
    # memoryAllocator.provider = "graphene-hardened"; # TODO: consider using this one, after a successful boot with scudo.
  };
  networking = {
    firewall = {
      # Close firewall
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };
  /* security = {
    chromiumSuidSandbox.enable = true;
    unprivilegedUsernsClone = true;
    }; */
  services = {
    clamav = {
      daemon.enable = true;
      updater.enable = true;
    };
  };
}
