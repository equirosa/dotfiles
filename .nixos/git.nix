{ pkgs, ... }: {
  environment.shellAliases = {
    git = "torify git";
    lazygit = "torify lazygit";
  };
  home-manager.users.eduardo = { pkgs, ... }: {
    programs.git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      aliases = {
        ca = "commit -a";
        pl = "pull";
        ps = "push";
        s = "status";
      };
      userEmail = "eduardo@eduardoquiros.com";
      userName = "Eduardo Quiros";
      ignores = [ "*~" "*.swp" ];
      signing = {
        key = "eduardo@eduardoquiros.com";
        signByDefault = true;
      };
    };
  };
  users.users.eduardo.packages = with pkgs; [
    lazygit
  ];
}
