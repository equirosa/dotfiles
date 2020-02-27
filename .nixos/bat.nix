{ config, ... }: {
  home-manager.users.eduardo = { pkgs, ... }: {
    programs.bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "Monokai Extended";
      };
    };
  };
}
