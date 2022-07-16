{
  pkgs,
  lib,
  ...
}: {
  imports = [
    # <nixpkgs/nixos/modules/profiles/hardened.nix>
    ./firejail.nix
    ./sudo.nix
  ];
  environment = {
    # Remove default packages to reduce attack surface.
    defaultPackages = lib.mkForce [];
    # memoryAllocator.provider = "graphene-hardened"; # TODO: consider using this one, after a successful boot with scudo.
  };
  networking = {
    firewall = let
    openPortRanges = [{from=3000; to=4000;}];
    in
    {
      # Close firewall
      enable = true;
      allowedTCPPorts = [];
      allowedTCPPortRanges = openPortRanges;
      allowedUDPPorts = [];
      allowedUDPPortRanges = openPortRanges;
    };
  };
  nix.settings.allowed-users = ["@wheel"];
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
