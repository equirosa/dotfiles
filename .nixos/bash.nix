{ config, ... }: {
  home-manager.users.eduardo = { pkgs, ... }: {
    programs.bash = {
      enable = true;
      enableAutoJump = true;
      historyControl = [ "erasedups" ];
      historyIgnore = [ "ls" "cd" "exit" ];
    };
  };
}
