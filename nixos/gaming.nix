{
  pkgs,
  lib,
  ...
}: let
  inherit (builtins) elem;
  inherit (lib) getExe;
  gscope = prog:
    pkgs.writeShellApplication {
      name =
        if prog == "steam"
        then "gaming"
        else "fgaming";
      runtimeInputs = [pkgs.xdg-user-dirs];
      text = ''
        ${getExe pkgs.gamescope} -e -- ${prog} -gamepadui
      '';
    };
in {
  users.users.kiri. packages = with pkgs; [
    (gscope "steam")
    (gscope "com.valvesoftware.Steam")
    mangohud
  ];
  programs = {
    gamemode.enable = true;
    steam.enable = true;
  };
  hardware = {
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
      extraPackages32 = [pkgs.pkgsi686Linux.libva];
    };
    steam-hardware.enable = true;
  };
  nix.settings = {
    substituters = [
      "https://nix-gaming.cachix.org"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg:
        elem (lib.getName pkg) [
          "steam-original"
          "steam-run"
          "steam-runtime"
          "steam"
        ];
    };
  };
  security.rtkit.enable = true;
}
