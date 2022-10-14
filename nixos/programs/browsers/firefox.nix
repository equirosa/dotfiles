{ pkgs, config, ... }: {
  home-manager.users.kiri = { config, ... }: {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox.override {
        cfg = { enableTridactylNative = true; };
      };
      enableGnomeExtensions = false;
    };
  };
}
