{ pkgs, ... }: {
  programs.vscode = {
    enable = false;
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      jnoortheen.nix-ide
      mkhl.direnv
    ];
    globalSnippets = { };
    userSettings = {
      "[nix]"."editor.tabSize" = 2;
      "editor.formatOnSave" = true;
      "files.autoSave" = "off";
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "catppuccin-mocha";
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "${pkgs.nixd}/bin/nixd";
    };
  };
}
