{ config, pkgs, ... }: {
  nixpkgs.overlays = [
    (
      import (
        builtins.fetchTarball {
          url =
            "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
        }
      )
    )
  ];
  home-manager.users.kiri = {
    services.emacs = {
      enable = true;
      client = {
        enable = true;
      };
      socketActivation.enable = true;
    };
    programs.emacs = {
      enable = true;
      package = pkgs.emacsPgtkGcc;
      extraPackages = epkgs: with epkgs; [
        # Miscellaneous
        evil # Vi keybinds

        # Org
        org-superstar
      ];
    };
  };
}
