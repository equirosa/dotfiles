{ pkgs
, lib
, ...
}:
let inherit (builtins) attrValues elem; in
{
  imports = [
    # "nix-gaming/modules/pipewireLowLatency.nix"
  ];
  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      wesnoth = {
        executable = "${pkgs.wesnoth}/bin/wesnoth";
        profile = "${pkgs.firejail}/etc/firejail/wesnoth.profile";
      };
    };
  };
  home-manager.users.kiri = {
    home = {
      sessionVariables.WINE_FULLSCREEN_FSR = 1;
      packages = attrValues {
        inherit (pkgs)
          # Games
          # nix-gaming.packages.x86_64-linux.rocket-league
          # Launchers
          lutris
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
    gamemode = { enable = true; };
    steam.enable = true;
  };
  hardware = {
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
      extraPackages32 = attrValues { inherit (pkgs.pkgsi686Linux) libva; };
    };
  };
  nix.settings = {
    substituters = [ "https://nix-gaming.cachix.org" ];
    trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
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
  services = {
    pipewire = {
      # lowLatency.enable = true;
    };
  };
  security.rtkit.enable = true;
}
