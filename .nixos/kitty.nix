{ config, pkgs, ... }: {
  environment = {
    shellAliases = {icat = "kitty +kitten icat"; };
  };
  users.users.eduardo = {
    packages = [ pkgs.kitty ];
    sessionVariables = {
      TERMINAL = "kitty";
    };
  };
}
