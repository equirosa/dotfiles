{ pkgs, config, ... }: {
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions;[
      arrterian.nix-env-selector
      bbenoist.nix
      jnoortheen.nix-ide
      mkhl.direnv
      pkief.material-icon-theme
    ];
    mutableExtensionsDir = false;
    userSettings = {
      "[nix]"."editor.tabSize" = 2;
      "files.autoSave" = "off";
      "workbench.iconTheme" = "material-icon-theme";
    };
  };
}
