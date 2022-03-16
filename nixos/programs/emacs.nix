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
          undo-tree
          # Vi keybinds
          evil
          # Nix
          envrc
          nix-mode
          nixpkgs-fmt
          # Org
          org-modern
          org-super-agenda
          org-timeline
          org-roam
          org-roam-ui
          org-roam-bibtex
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
