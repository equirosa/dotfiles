{ config, pkgs, ... }: {
  home-manager.users.eduardo = { ... }: {
    services.syncthing = {
      enable = true;
      tray = true;
    };
  };
}
