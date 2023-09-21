{ pkgs
, lib
, nix-gaming
, ...
}:
let
  inherit (builtins) elem;
  args = [
    "-h 720"
    "-H 1080"
    "-F fsr"
    "-r 144"
  ];
in
{
  users.users.kiri. packages = with pkgs; [
    lutris
    mangohud
    nix-gaming.packages.${pkgs.system}.rocket-league
  ];
  programs = {
    gamemode.enable = true;
    gamescope = {
      enable = true;
      inherit args;
    };
    steam = {
      enable = true;
      gamescopeSession = {
        enable = true;
        inherit args;
      };
    };
  };
  hardware = {
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
      extraPackages32 = [ pkgs.pkgsi686Linux.libva ];
    };
    steam-hardware.enable = true;
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
