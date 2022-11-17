{ pkgs, ... }: {
  qt5 = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
  gtk.iconCache.enable = true;
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Fira Code" "FiraCode Nerd Font" "Twitter Color Emoji" ];
        emoji = [ "Twitter Color Emoji" ];
      };
    };
    fontDir.enable = true;
    fonts = with pkgs; [
      dejavu_fonts
      emacs-all-the-icons-fonts
      fira-code
      font-awesome
      liberation_ttf
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
      twitter-color-emoji
    ];
  };
  home-manager.users.kiri = { pkgs, ... }:
    let
      gtk-extra-config = { gtk-application-prefer-dark-theme = true; };
    in
    {
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
    };
}
