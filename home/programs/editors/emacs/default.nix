{ pkgs, ... }:
let enable = false; in
{
  programs.emacs = {
    inherit enable;
    package = pkgs.emacsWithPackagesFromUsePackage {
      config = ./init.el;
      package = pkgs.emacs-pgtk;
      alwaysEnsure = true;
      alwaysTangle = false;
      defaultInitFile = true;
    };
  };
  services.emacs = {
    inherit enable;
    client = { enable = true; arguments = [ "--create-frame" ]; };
    defaultEditor = true;
  };
}
