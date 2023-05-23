{pkgs, ...}: let
  gtk-extra-config = {gtk-application-prefer-dark-theme = true;};
in {
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
    gtk3.extraConfig = gtk-extra-config;
    gtk4.extraConfig = gtk-extra-config;
  };
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark";
    };
  };
}
