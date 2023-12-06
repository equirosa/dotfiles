{ pkgs, ... }: {
  imports = [
    ./backups
    ./btrfs.nix
    ./extra_security
    ./gaming.nix
    ./hardware/zsa.nix
    ./fonts.nix
    ./virtualization/podman.nix
  ];
  users.users.kiri.shell = pkgs.fish;
  programs.fish = {
    enable = true;
    useBabelfish = true;
  };
  programs.gnome-disks.enable = true;
  boot = {
    tmp.useTmpfs = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };
  hardware.enableRedistributableFirmware = true;
  networking.hostFiles = map (x: "${pkgs.stevenblack-blocklist}/" + x) [
    "hosts"
    "alternates/gambling/hosts"
  ];
  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
      persistent = true;
    };
    settings.system-features = [ "kvm" "nixos-test" "recursive-nix" ];
  };
  security.pam.services.login.gnupg.enable = true;
  services = {
    dbus.packages = [ pkgs.gcr ];
    resolved = {
      enable = true;
      dnssec = "true";
      extraConfig = ''
        [Resolve]
        DNS=45.90.28.0#149cea.dns.nextdns.io
        DNS=2a07:a8c0::#149cea.dns.nextdns.io
        DNS=45.90.30.0#149cea.dns.nextdns.io
        DNS=2a07:a8c1::#149cea.dns.nextdns.io
        DNSOverTLS=yes
      '';
    };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
    };
    tor = {
      enable = true;
      client = {
        enable = true;
        dns.enable = true;
      };
    };
    udisks2.enable = true;
  };
  system.autoUpgrade = {
    enable = true;
    dates = "05:00:00";
  };
}
