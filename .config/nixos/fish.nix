{ config, pkgs, ... }: {
  home-manager.users.eduardo = {
    programs.fish = {
      enable = true;
      shellAbbrs = {
        "ls" = "ls -h --color=always";
        "l" = "ls -l";
        "ll" = "ls -la";
      };
    };
  };
  users.users.eduardo.shell = pkgs.fish;
}
