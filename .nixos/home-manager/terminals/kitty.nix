{ config, pkgs, ... }: {
  environment = {
    shellAliases = {icat = "kitty +kitten icat"; };
    variables = {
      TERMINAL = "kitty";
    };
  };
  users.users.eduardo = {
    packages = [ pkgs.kitty ];
  };
}
