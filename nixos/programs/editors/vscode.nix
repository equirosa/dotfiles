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
      "files.autoSave" = "off";
      "[nix]"."editor.tabSize" = 2;
      "workbench.iconTheme" = "material-icon-theme";
    };
  };
}
