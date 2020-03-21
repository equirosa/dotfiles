{ config, ... }: {
  imports = [ ./starship.nix ];
  home-manager.users.eduardo = { pkgs, ... }: {
    programs.bash = {
      enable = true;
      enableAutojump = true;
      historyControl = [ "erasedups" ];
      historyIgnore = [ "ls" "cd" "exit" ];
    };
  };
}
