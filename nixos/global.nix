{ config
, pkgs
, ...
}:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
    ./audio
    ./backups
    ./extra_security
    ./gaming.nix
    ./graphical/wayland/sway.nix
    ./programs
    ./shell
    ./theme.nix
    ./virtualization/qemu.nix
  ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.kiri = {
      programs = {
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
        gpg = {
          enable = true;
        };
        keychain = {
          enable = true;
          agents = [ "ssh" "gpg" ];
          keys = [ "id_ed25519" "B77F36C3F12720B4" ];
          extraFlags = [
            "--quiet"
          ];
        };
        less = { enable = true; };
        ssh = { enable = true; };
      };
      services = {
        gpg-agent = {
          enable = true;
          defaultCacheTtl = 34560000;
          maxCacheTtl = 34560000;
          enableScDaemon = false;
          enableSshSupport = true;
          extraConfig = ''
            allow-emacs-pinentry
            allow-loopback-pinentry
          '';
        };
        syncthing = {
          enable = true;
          tray.enable = true;
        };
        udiskie = { enable = true; };
      };
    };
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableRedistributableFirmware = true;
  networking = {
    hostFiles = [ "${pkgs.stevenblack-blocklist}/hosts" "${pkgs.stevenblack-blocklist}/alternates/gambling/hosts" ];
  };
  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 30d";
      persistent = true;
    };
    settings = { auto-optimise-store = true; };
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
            (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz")
            { inherit pkgs; };
      };
    };
  };
  security = { pam = { services = { login = { gnupg.enable = true; }; }; }; };
  services = {
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
    tor = {
      enable = true;
      client = {
        enable = true;
        dns.enable = true;
      };
    };
    udisks2.enable = true;
  };
  system = {
    autoUpgrade = {
      enable = true;
      dates = "weekly";
    };
  };
}
