{ config, pkgs, ... }: {
  users.users.eduardo = {
    createHome = true;
    description = "Eduardo Quiros";
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
    home = "/home/eduardo";
    initialHashedPassword = "$6$n3GzxIULPTTidjy$8TABYAaFlEo/I49XGq1WpUCxpIZzrbxddlAXudwisO7S4y2Xi1e7ZQtUp1b/F8HiXLFi.WUBEie.a9/R/ewoJ0";
    isNormalUser = true;
  };
}
