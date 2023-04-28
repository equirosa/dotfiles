{ pkgs
, lib
, ...
}:
let inherit (builtins) attrValues elem; in
{
  home-manager.users.kiri = {
    home = {
      packages = attrValues {
        inherit (pkgs)
          # Games
          # nix-gaming.packages.x86_64-linux.rocket-league
          # Launchers
          lutris
          prismlauncher
          # General games client
          legendary-gl
          # Utilities
          chiaki# PS4 Remote Play utility
          gamescope
          mangohud;
      };
    };
  };
  programs = {
    gamemode.enable = true;
    steam.enable = true;
  };
  hardware = {
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
      extraPackages32 = [ pkgs.pkgsi686Linux.libva ];
    };
    steam-hardware.enable = true;
  };
  nix.settings = {
    trusted-substituters = [
      "https://nix-gaming.cachix.org"
      "https://nix-community.cachix.org"
    ];
    substituters = [
      "https://nix-gaming.cachix.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
  };
  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg: elem (lib.getName pkg) [
        "steam-original"
        "steam-run"
        "steam-runtime"
        "steam"
      ];
    };
  };
  security.rtkit.enable = true;
}
