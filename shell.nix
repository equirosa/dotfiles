with import <nixpkgs> {};
  mkShell {
    nativeBuildInputs = [
      alejandra
      rnix-lsp
      statix
    ];
  }
