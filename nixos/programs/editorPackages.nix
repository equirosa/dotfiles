{ pkgs, ... }:
with pkgs; [
  # LSP
  deno
  gopls
  nodePackages.yaml-language-server
  nodePackages.typescript
  nodePackages.typescript-language-server
  python310Packages.python-lsp-server
  rnix-lsp
  rust-analyzer
  sumneko-lua-language-server
  texlab
]
