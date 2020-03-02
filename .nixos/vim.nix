{ config, pkgs, ...}: {
  home-manager.users.eduardo = { pkgs, ...}: {
    programs.vim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        lf-vim
        vim-nix
      ];
      settings = {
        background = "dark";
        backupdir = [ "$HOME/.cache/vim_backups/" ];
        expandtab = false;
        mouse = "a";
        number = true;
        relativenumber = true;
      };
    };
  };
}
