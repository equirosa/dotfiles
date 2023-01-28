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
      package = pkgs.emacsNativeComp;
      alwaysEnsure = true;
      alwaysTangle = false;
      defaultInitFile = true;
    };
  };
}
