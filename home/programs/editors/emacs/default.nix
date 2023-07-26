{ pkgs, ... }:
let enable = true; in {
  programs.emacs = {
    inherit enable;
    package = pkgs.emacsWithPackagesFromUsePackage {
      config = ./init.el;
      package = pkgs.emacsPgtk;
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
