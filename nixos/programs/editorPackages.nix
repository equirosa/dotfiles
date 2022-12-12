{ pkgs, ... }:
with pkgs; [
  # LSP
  deno
  gopls
  nodePackages.yaml-language-server
  nodePackages.typescript
  nodePackages.typescript-language-server
  rnix-lsp
  rust-analyzer
  sumneko-lua-language-server
  texlab
]
