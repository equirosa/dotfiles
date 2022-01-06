{ pkgs, lib, ... }: {
  home-manager.users.kiri = {
    home = {
      packages = with pkgs; [
        # Games
        openra
        taisei
        warzone2100
        wesnoth
        zeroad
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
}
