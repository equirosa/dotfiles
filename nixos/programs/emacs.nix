{ config
, pkgs
, ...
}: {
  nixpkgs.overlays = [
    (import
      (builtins.fetchTarball {
        url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
      }))
  ];
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
      package = pkgs.emacsPgtkNativeComp;
      alwaysEnsure = true;
      alwaysTangle = false;
      defaultInitFile = true;
      extraEmacsPackages = epkgs: builtins.attrValues {
        inherit (epkgs);
      };
    };
  };
}
