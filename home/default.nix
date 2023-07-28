{ lib, overlays, inputs, ... }: {
  imports = [ ./graphical ./theme.nix ./shell ./programs ];
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "vscode" ];
  programs = {
    nix-index-database.comma.enable = true;
    nix-index.enable = true;
  };
  xdg.userDirs.enable = true;
}
