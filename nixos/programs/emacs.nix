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
      client = {enable = true;};
      socketActivation.enable = true;
    };
    programs.emacs = {
      enable = true;
      package = pkgs.emacsPgtkGcc;
      extraPackages = epkgs:
        with epkgs; [
          # Programming
          company
          tree-sitter
          tree-sitter-langs
          # Miscellaneous
          linum-relative
          # Vi keybinds
          evil
          # Nix
          envrc
          nix-mode
          nixpkgs-fmt
          # Org
          org-superstar
          # Style
          all-the-icons
          all-the-icons-dired
          doom-modeline
          gruvbox-theme
          rainbow-delimiters
        ];
    };
  };
}
