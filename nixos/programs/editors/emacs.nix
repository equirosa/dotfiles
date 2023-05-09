{ pkgs
, ...
}: {
  services.emacs = {
    enable = true;
    defaultEditor = true;
    package = pkgs.emacsWithPackagesFromUsePackage {
      config = ./emacs-config/config.el;
      package = pkgs.emacsPgtk;
      alwaysEnsure = true;
      alwaysTangle = false;
      defaultInitFile = true;
    };
  };
}
