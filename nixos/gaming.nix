{ pkgs
, inputs
, ...
}:
{
  users.users.kiri.packages = with pkgs; [
    lutris
    mangohud
    inputs.nix-gaming.packages.${pkgs.system}.rocket-league
  ];
  programs = {
    gamemode.enable = true;
    steam = {
      enable = true;
      gamescopeSession = {
        enable = true;
        args = [
          "-h 720"
          "-H 1080"
          "-F fsr"
          "-r 144"
        ];
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
  security.rtkit.enable = true;
}
