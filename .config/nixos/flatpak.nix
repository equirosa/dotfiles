{ config, pkgs, ... }: {
  environment = {
    shellAliases = {
      flatinstall = " flatpak install -y";
      flatun = "flatpak uninstall";
    };
  };
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-kde ];
    gtkUsePortal = true;
  };
}
