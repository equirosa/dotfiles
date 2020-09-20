{ pkgs ? import <nixpkgs> {} }:
let
  myEmacs = (
    pkgs.emacs.override {
      withGTK3 = true;
      withGTK2 = false;
    }
  ).overrideAttrs (
    attrs: {
      postInstall = (attrs.postInstall or "") + ''
        rm $out/share/applications/emacs.desktop
      '';
    }
  );
  emacsWithPackages = (pkgs.emacsPackagesGen myEmacs).emacsWithPackages;
in
emacsWithPackages (
  epkgs:
    (with epkgs.melpaStablePackages; []) ++ (
      with epkgs.melpaPackages; [
        # Completions
        bash-completion
        company
        eglot
        lsp-mode
        # Cosas de Nix
        nix-mode
        # Misc.
        pandoc-mode
        fzf
        all-the-icons
        password-store
        keychain-environment
        evil
        magit
        scribble-mode
        #### Theming ####
        gruvbox-theme
        #### Org ####
        babel
      ]
    ) ++ (with epkgs.elpaPackages; [ auctex beacon ])
    ++ (with pkgs; [ emacs-all-the-icons-fonts ])
)
