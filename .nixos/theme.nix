{ config, pkgs, ... }: {
  home-manager.users.eduardo = { pkgs, ... }: {
    gtk = {
      enable = true;
      font = {
        # package = pkgs.fira-code;
        name = "Fira Code 10";
      };
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };
      theme = {
        package = pkgs.arc-theme;
        name = "Arc-Dark";
      };
    };
    qt = {
      enable = true;
      platformTheme = "gtk";
    };
  };
}
