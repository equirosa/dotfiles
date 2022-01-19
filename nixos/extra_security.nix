{ pkgs, ... }: {
  imports = [ <nixpkgs/nixos/modules/profiles/hardened.nix> ];
  environment = {
    # memoryAllocator.provider = "graphene-hardened"; # TODO: consider using this one, after a successful boot with scudo.
  };
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };
  programs = {
    firejail = {
      enable = true;
      wrappedBinaries = {
        firefox = {
          executable = "${pkgs.lib.getBin pkgs.firefox}/bin/firefox";
          profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
        };
      };
    };
  };
  services = {
    clamav = {
      daemon.enable = true;
      updater.enable = true;
    };
  };
}
