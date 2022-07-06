{pkgs, ...}:
with pkgs; [
  # LSP
  rnix-lsp
  rust-analyzer
  nodePackages.typescript
  nodePackages.typescript-language-server
  nodePackages.prettier
  sumneko-lua-language-server
]
