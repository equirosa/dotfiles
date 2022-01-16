{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
    ./audio/default.nix
    ./gaming.nix
    ./programs/all.nix
    ./shell/default.nix
    ./sway.nix
    ./theme.nix
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.kiri = {
      home = {
        sessionVariables = {
          EDITOR = "${pkgs.neovim}/bin/nvim";
        };
      };
      programs = {
        gpg = {
          enable = true;
        };
        keychain = {
          enable = true;
          agents = [ ];
          keys = [ "id_ed25519" ];
        };
        less = {
          enable = true;
        };
        ssh = {
          enable = true;
        };
      };
      services = {
        gpg-agent = {
          enable = true;
          enableScDaemon = false;
          enableSshSupport = true;
        };
        syncthing = {
          enable = true;
          tray.enable = true;
        };
        udiskie = {
          enable = true;
        };
      };
    };
  };
  networking = {
    hostFiles = [
      "${pkgs.stevenblack-blocklist}/hosts"
      "${pkgs.stevenblack-blocklist}/alternates/gambling/hosts"
    ];
  };
  nix = {
    autoOptimiseStore = true;
    extraOptions = ''
      experimental-features = flakes nix-command
    '';
  };
  nixpkgs = {
    config = {
      packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
          inherit pkgs;
        };
      };
    };
  };
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
    udisks2.enable = true;
  };
}
