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
        lsp-ui
        dap-mode
        flycheck
        # Cosas de Nix
        direnv
        nix-mode
        # Misc.
        pandoc-mode
        fzf
        all-the-icons
        all-the-icons-dired
        rainbow-delimiters
        password-store
        keychain-environment
        evil
        magit
        scribble-mode
        #### Theming ####
        doom-themes
        doom-modeline
        fira-code-mode
        #### Org ####
        babel
      ]
    ) ++ (with epkgs.elpaPackages; [ auctex beacon ])
    ++ (with pkgs; [ emacs-all-the-icons-fonts ])
)
