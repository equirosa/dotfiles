{ pkgs ? import <nixpkgs> { } }:
with pkgs;
mkShell {
  buildInputs = [
    nixpkgs-fmt
    rnix-lsp
    shfmt
    stylua
    nodePackages.bash-language-server
  ];
  shellHook = ''
    # ...
  '';
}
