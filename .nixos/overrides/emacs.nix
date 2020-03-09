{ pkgs ? import <nixpkgs> { } }:
let
  myEmacs = (pkgs.emacs.override {
    withGTK3 = true;
    withGTK2 = false;
  }).overrideAttrs (attrs: {
    postInstall = (attrs.postInstall or "") + ''
      rm $out/share/applications/emacs.desktop
    '';
  });
  emacsWithPackages = (pkgs.emacsPackagesGen myEmacs).emacsWithPackages;
in emacsWithPackages (epkgs:
  (with epkgs.melpaStablePackages; [ ]) ++ (with epkgs.melpaPackages; [
    # Cosas de GO
    go-mode
    company-go
    # Cosas de RUST
    rust-mode
    racer
    flycheck-rust
    # Cosas de Nix
    nix-mode
    # Cosas de Markdown
    auto-org-md
    markdown-mode
    # Misc.
    password-store
    company
    evil
    magit
    pdf-tools
    transmission
    #### Theming ####
    gruvbox-theme
    monokai-theme
  ]) ++ (with epkgs.elpaPackages; [ auctex beacon ]) ++ (with pkgs; [ ]))
