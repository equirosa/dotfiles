{ pkgs, ... }: {
  imports = [
    ./editors/neovim
    ./editors/vscode.nix
    ./file-manager.nix
    ./git.nix
    ./mpv.nix
    ./scripts
    ./terminal
    ./zellij.nix
  ];
  home.packages = with pkgs; [
    nix-prefetch-github
  ];
}
