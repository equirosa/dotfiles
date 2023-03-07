{ pkgs, config, ... }: {
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions;[
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
