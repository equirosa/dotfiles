{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
    ];
    globalSnippets = { };
    userSettings = {
      "[nix]"."editor.tabSize" = 2;
      "editor.formatOnSave" = true;
      "files.autoSave" = "off";
    };
  };
}
