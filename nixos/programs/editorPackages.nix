{ pkgs, ... }:
with pkgs; [
  # LSP
  deno
  nodePackages.prettier
  nodePackages.yaml-language-server
  rnix-lsp
  rust-analyzer
  sumneko-lua-language-server
]
