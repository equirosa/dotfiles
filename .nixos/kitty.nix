{ config, pkgs, ... }: {
  home-manager.users.eduardo = { pkgs, ... }: {
    home = {
      file.kittyconf = {
        source = ./config/kitty/kitty.conf;
        target = ".config/kitty/kitty.conf";
      };
    };
  };
  environment = {
    shellAliases = {icat = "kitty +kitten icat"; };
    sessionVariables = {
      TERMINAL = "kitty";
    };
  };
  users.users.eduardo.packages = [ pkgs.kitty ];
}
