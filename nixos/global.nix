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
  boot = {
    tmp.useTmpfs = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };
  hardware.enableRedistributableFirmware = true;
  networking = {
    hostFiles = map (x: "${pkgs.stevenblack-blocklist}/" + x) [
      "hosts"
      "alternates/gambling/hosts"
    ];
    hosts = { "0.0.0.0" = [ "*.zip" "*.mov" ]; };
  };
  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
      persistent = true;
    };
    settings.auto-optimise-store = true;
    settings.system-features = [ "recursive-nix" ];
    # registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = flakes nix-command recursive-nix
      keep-outputs = true
      keep-derivations = true
    '';
  };
  security.pam.services.login.gnupg.enable = true;
  services = {
    dbus.packages = [ pkgs.gcr ];
    dnscrypt-proxy2 = {
      enable = true;
      settings = {
        sources.public-resolvers = {
          urls = [ "https://download.dnscrypt.info/resolvers-list/v2/public-resolvers.md" ];
          cache_file = "public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
          refresh_delay = 72;
        };
      };
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
