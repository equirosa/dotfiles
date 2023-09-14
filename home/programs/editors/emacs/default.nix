{ pkgs, ... }:
let enable = true; in {
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
    emacsPackage = pkgs.emacs-pgtk;
  };
}
