{lib, ...}: {
  imports = [./graphical ./theme.nix ./shell ./programs];
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) ["vscode"];
}
