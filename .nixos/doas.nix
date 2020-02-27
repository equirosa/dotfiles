{ config, pkgs, ... }: {
  environment = {
    etc.doasConf = {
      enable = true;
      target = "doas.conf";
      text = "permit eduardo as root";
    };
  };
  users.users.eduardo.packages = [ pkgs.doas ];
}
