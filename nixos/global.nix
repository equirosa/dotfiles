{ config
, pkgs
, lib
, ...
}:
let
  inherit (builtins) fetchTarball;
  inherit (lib) getExe;
  home-manager = fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
    ./backups
    ./btrfs.nix
    ./extra_security
    ./gaming.nix
    ./graphical/wayland/sway.nix
    ./hardware/zsa.nix
    ./services/jellyfin.nix
    ./printing.nix
    ./programs
    ./shell
    ./theme.nix
    ./virtualization/podman.nix
    ./virtualization/qemu.nix
  ];
  users.users.kiri = { extraGroups = [ "adbusers" "ipfs" ]; };
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.kiri = {
      home = { inherit (config.system) stateVersion; };
      xdg.userDirs.enable = true;
    };
  };
  boot = {
    tmpOnTmpfs = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };
  hardware.enableRedistributableFirmware = true;
  networking = {
    hostFiles = map (x: "${pkgs.stevenblack-blocklist}/" + x) [
      "hosts"
      "alternates/gambling/hosts"
    ];
  };
  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
      persistent = true;
    };
    settings = { auto-optimise-store = true; };
    package = pkgs.nixVersions.stable;
    # registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = flakes nix-command
      keep-outputs = true
      keep-derivations = true
    '';
  };
  nixpkgs = {
    config = {
      packageOverrides = pkgs: {
        nur =
          import
            (fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz")
            { inherit pkgs; };
      };
    };
  };
  security = { pam = { services = { login = { gnupg.enable = true; }; }; }; };
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
    kubo = { enable = true; };
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
  programs.adb.enable = true;
  system = {
    autoUpgrade = {
      enable = true;
      dates = "05:00:00";
    };
  };
  zramSwap.enable = true;
}
