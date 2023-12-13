{ pkgs
, inputs
, ...
}:
let
  gamescope = {
    enable = true;
    args = [
      "-h 1080"
      "-F fsr"
      "-r 144"
    ];
  };
in
{
  users.users.kiri.packages = with pkgs; [
    lutris
    mangohud
    inputs.nix-gaming.packages.${pkgs.system}.rocket-league
  ];
  programs = {
    inherit gamescope;
    gamemode.enable = true;
    steam = {
      enable = true;
      gamescopeSession = gamescope;
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
  security.rtkit.enable = true;
}
