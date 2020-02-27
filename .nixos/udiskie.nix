{ config, ... }: {
  home-manager.users.eduardo = { pkgs, ... }: {
    services.udiskie = {
      enable = true;
      automount = true;
      notify = true;
      tray = "auto";
    };
  };
}
