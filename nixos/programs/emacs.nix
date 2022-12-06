{ config
, pkgs
, ...
}: {
  services.emacs = {
    enable = true;
    client = {
      enable = true;
      arguments = [ "-c" "-a 'emacs'" ];
    };
    defaultEditor = true;
    socketActivation.enable = false;
  };
  programs.emacs = {
    enable = true;
    package = pkgs.emacsWithPackagesFromUsePackage {
      config = ../../emacs/init.el;
      package = pkgs.emacsPgtk;
      alwaysEnsure = true;
      alwaysTangle = false;
      defaultInitFile = true;
      extraEmacsPackages = epkgs: builtins.attrValues {
        inherit (epkgs);
      };
    };
  };
}
