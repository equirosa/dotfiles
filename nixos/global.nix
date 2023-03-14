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
      home = {
        sessionVariables = {
          BROWSER = "${getExe pkgs.firefox} -p default";
          TERMINAL_BROWSER = "${getExe pkgs.w3m}";
        };
        inherit (config.system) stateVersion;
      };
      programs = {
        direnv = {
          enable = true;
          nix-direnv.enable = true;
          config = {
            global = {
              bash_path = "${getExe pkgs.bash}";
              load_dotenv = true;
              strict_env = true;
            };
            whitelist = {
              prefix = [ "/home/kiri/projects" ];
            };
          };
        };
        gpg = {
          enable = true;
          settings.default-key = "03678E9642EB6D9E99974ACFB77F36C3F12720B4";
        };
        keychain = {
          enable = true;
          agents = [ "ssh" "gpg" ];
          keys = [ "id_ed25519" "B77F36C3F12720B4" ];
          extraFlags = [ "--quiet" ];
        };
        less.enable = true;
        ssh.enable = true;
        tealdeer = {
          enable = true;
          settings = {
            display = {
              compact = false;
              use_pager = false;
            };
            updates.auto_update = true;
          };
        };
      };
      services = {
        gpg-agent = {
          enable = true;
          defaultCacheTtl = 34560000;
          maxCacheTtl = 34560000;
          enableScDaemon = false;
          enableSshSupport = true;
          pinentryFlavor = "gnome3";
          extraConfig = ''
            allow-emacs-pinentry
            allow-loopback-pinentry
          '';
        };
        syncthing = {
          enable = true;
          tray.enable = true;
        };
        udiskie.enable = true;
      };
      xdg.userDirs.enable = true;
    };
  };
  boot = {
    tmpOnTmpfs = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };
  hardware.enableRedistributableFirmware = true;
  hardware.keyboard.zsa.enable = true;
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
    package = pkgs.nixUnstable;
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
      dates = "daily";
    };
  };
  zramSwap.enable = true;
}
