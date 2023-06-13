{pkgs, ...}: {
  services.emacs = {
    enable = true;
    defaultEditor = true;
    package = pkgs.emacsWithPackagesFromUsePackage {
      config = ./init.el;
      package = pkgs.emacsPgtk;
      alwaysEnsure = true;
      alwaysTangle = false;
      defaultInitFile = true;
    };
  };
}
