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
    programs.emacs = {
      enable = true;
      package = pkgs.emacsWithPackagesFromUsePackage {
        config = "/home/kiri/.config/emacs/init.el";
        package = pkgs.emacsNativeComp;
        alwaysEnsure = true;
        alwaysTangle = false;
        extraEmacsPackages = epkgs:
          with epkgs;
          with pkgs;
            [
              # Utilities
              vterm
              # Normal Packages
              pkgs.gcc
              pkgs.sqlite # For org-roam
              pkgs.unzip
              pkgs.tectonic
              pkgs.texlive.combined.scheme-full
            ]
            ++ import ./editorPackages.nix {inherit pkgs;};
      };
    };
  };
}
