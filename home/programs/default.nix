{ pkgs
, ...
}: {
  imports = [
    ./editors/neovim
    ./editors/vscode.nix
    ./git.nix
    ./file-manager.nix
    ./mpv.nix
    ./terminal
    ./zellij.nix
  ];
}
