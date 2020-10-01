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
        # Browsers/Comms
        elpher
        # Completions
        bash-completion
        fish-completion
        company
        lsp-mode
        lsp-ui
        dap-mode
        flycheck
        ## Java
        jetbrains
        lsp-java
        # Cosas de Nix
        direnv
        nix-mode
        # Style
        rainbow-delimiters
        # Misc.
        pandoc-mode
        fzf
        password-store
        keychain-environment
        evil
        magit
        scribble-mode
        #### Theming ####
        doom-themes
        doom-modeline
        all-the-icons
        all-the-icons-dired
        fira-code-mode
        #### Utilities
        deadgrep
        ffmpeg-player
        #### Org ####
        babel
        org-bullets
        org-brain
      ]
    ) ++ (with epkgs.elpaPackages; [ auctex beacon ])
    ++ (with pkgs; [ emacs-all-the-icons-fonts ])
)
