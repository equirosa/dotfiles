{ config, pkgs, ... }: {
  services.emacs = {
    enable = true;
    package = (import ../overrides/emacs.nix { pkgs = pkgs; });
    defaultEditor = false;
  };
}
