{
  config,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [
    (
      import
      (builtins.fetchTarball {url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";})
    )
  ];
  home-manager.users.kiri = {
    services.emacs = {
      enable = true;
      client = {
        enable = true;
        arguments = ["-c" "-a 'emacs'"];
      };
      defaultEditor = true;
      socketActivation.enable = false;
    };
    programs.emacs = {
      enable = true;
      package = pkgs.emacsWithPackagesFromUsePackage {
        config = "/home/kiri/.config/emacs/init.el";
        package = pkgs.emacsNativeComp;
        alwaysEnsure = true;
        alwaysTangle = false;
        extraEmacsPackages = epkgs:
          with epkgs; [
            # Utilities
            vterm
            pkgs.gcc
            pkgs.sqlite
            pkgs.unzip
          ];
      };
    };
  };
}
