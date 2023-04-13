{ config
, pkgs
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
      arguments = [ "-c" "-a 'emacs'" ];
    };
    defaultEditor = true;
    socketActivation.enable = false;
  };
  programs.emacs = {
    inherit enable;
    package = pkgs.emacsWithPackagesFromUsePackage {
      config = ./emacs-config/init.el;
      package = pkgs.emacsPgtk;
      alwaysEnsure = true;
      alwaysTangle = false;
      defaultInitFile = true;
    };
  };
  nix.settings = {
    trusted-substituters = [ "https://nix-community.cachix.org" ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
