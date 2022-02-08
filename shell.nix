with import <nixpkgs> { };
mkShell {
  nativeBuildInputs = [
    rnix-lsp
		statix
  ];
}
