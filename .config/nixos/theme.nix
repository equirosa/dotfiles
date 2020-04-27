{ config, pkgs, ... }: {
  home-manager.users.eduardo = { pkgs, ... }: {
    gtk = {
      enable = true;
      font = {
        package = pkgs.nerdfonts;
        name = "Fira Code Nerd Font";
      };
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };
      theme = {
        package = pkgs.adapta-gtk-theme;
        name = "Adapta-Nokto-Eta";
      };
    };
    qt = {
      enable = true;
      platformTheme = "gtk";
    };
  };
}
