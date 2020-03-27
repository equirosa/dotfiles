{ config, ... }: {
  home-manager.users.eduardo = { pkgs, ... }: {
    services.kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}
