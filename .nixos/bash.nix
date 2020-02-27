{ config, ... }: {
  home-manager.users.eduardo = { pkgs, ... }: {
    programs.bash = {
      enable = true;
      historyControl = [ "erasedups" ];
      historyIgnore = [ "ls" "cd" "exit" ];
    };
  };
}
