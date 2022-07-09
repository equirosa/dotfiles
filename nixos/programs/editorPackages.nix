{ pkgs, ... }:
with pkgs; [
  # LSP
  nodePackages.prettier
  nodePackages.typescript
  nodePackages.typescript-language-server
  rnix-lsp
  rust-analyzer
  sumneko-lua-language-server
]
