{ config, pkgs, ... }: {
  home-manager.users.eduardo = { pkgs, ... }: {
    programs.htop = {
      enable = true;
      cpuCountFromZero = true;
      highlightMegabytes = true;
      treeView = true;
    };
    home.sessionVariables = { MONITOR = "htop"; };
  };
  environment.shellAliases = { top = "htop"; };
}
