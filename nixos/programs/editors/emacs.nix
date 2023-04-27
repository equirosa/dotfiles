{ pkgs
, ...
}:
let
  enable = true;
in
{
  services.emacs = {
    inherit enable;
    client = {
      enable = true;
      arguments = [ "-c" "-a" "'emacs'" ];
    };
    defaultEditor = true;
    socketActivation.enable = false;
  };
  programs.emacs = {
    inherit enable;
    package = pkgs.emacsWithPackagesFromUsePackage {
      config = ./emacs-config/config.el;
      package = pkgs.emacsUnstable;
      alwaysEnsure = true;
      alwaysTangle = false;
      defaultInitFile = true;
    };
  };
}
