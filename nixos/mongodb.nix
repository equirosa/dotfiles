{ pkgs, config, ... }: {
  services.mongodb = {
    enable = true;
    package = pkgs.mongodb-3_6;
  };
  home-manager.users.kiri = {
    home.packages = [ pkgs.mongodb-compass ];
  };
}
