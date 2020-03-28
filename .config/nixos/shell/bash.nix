{ config, ... }: {
  home-manager.users.eduardo = { pkgs, ... }: {
    programs.bash = {
      enable = true;
      enableAutojump = true;
      historyControl = [ "erasedups" ];
      historyFile = "$HOME/.cache/bash_history";
      historyIgnore = [ "ls" "cd" "exit" ];
      initExtra = ''
        [ -f "$HOME/.profile" ] && source "$HOME/.profile"
      '';
    };
  };
}
