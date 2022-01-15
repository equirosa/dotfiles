{ pkgs, lib, ... }:
let
  nix-gaming = import (builtins.fetchTarball "https://github.com/fufexan/nix-gaming/archive/master.tar.gz");
in
{
  imports = [
    # "nix-gaming/modules/pipewireLowLatency.nix"
  ];
  home-manager.users.kiri = {
    home = {
      packages = with pkgs; [
        # Games
        openra
        taisei
        warzone2100
        wesnoth
        zeroad
        nix-gaming.packages.x86_64-linux.rocket-league
        # Launchers
        eidolon
        lutris # General games client
        legendary-gl
        # Utilities
        chiaki # PS4 Remote Play utility
        mangohud
        protonup
      ];
      file = {
        "5.21-GE-1" = {
          recursive = true;
          source = pkgs.fetchFromGitHub {
            owner = "GloriousEggroll";
            repo = "proton-ge-custom";
            rev = "5.21-GE-1";
            sha256 = "sha256-zefu/8DWhdQmoAFZiWr1S6UvLtRunNT+kSF5Qe1Y0nA=";
          };
          target = ".steam/root/compatibilitytools.d/Proton-5.21-GE-1";
        };
      };
    };
  };
  programs.steam.enable = true;
  hardware = {
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    };
  };
  nix = {
    binaryCaches = [ "https://nix-gaming.cachix.org" ];
    binaryCachePublicKeys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
  };
  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "discord"
        "steam"
        "steam-runtime"
        "steam-run"
        "steam-original"
      ];
    };
  };
  services = {
    pipewire = {
      # lowLatency.enable = true;
    };
  };
  security.rtkit.enable = true;
}
