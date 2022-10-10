{ pkgs, config, ... }: {
  services.mongodb = {
    enable = true;
    package = pkgs.mongodb-5_0;
  };
  home-manager.users.kiri = {
    home.packages = [ pkgs.mongodb-compass ];
  };
}
