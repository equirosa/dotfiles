{ pkgs ? import <nixpkgs> { } }:
with pkgs;
mkShell {
  buildInputs = [
    nixpkgs-fmt
    shfmt
    stylua
    nodePackages.bash-language-server
  ];
  shellHook = ''
    # ...
  '';
}
