{ config, pkgs, ...}: {
  home-manager.users.eduardo = { pkgs, ...}: {
    home = {
      sessionVariables = {
        EDITOR = "vim";
      };
    };
    programs.vim = {
      enable = true;
      extraConfig = ''
        filetype plugin indent on
        syntax enable
        colorscheme gruvbox
        let g:airline_theme = 'gruvbox' 
      '';
      plugins = with pkgs.vimPlugins; [
        auto-pairs
        bclose-vim
        fugitive
        goyo
        gruvbox-community
        lf-vim
        neomake
        nerdcommenter
        vim-airline
        vim-airline-themes
        vim-css-color
        vim-nix
        youcompleteme
      ];
      settings = {
        background = "dark";
        #backupdir = [ "$HOME/.cache/vim_backups/" ];
        expandtab = false;
        mouse = "a";
        number = true;
        relativenumber = true;
        shiftwidth = 4;
        tabstop = 4;
      };
    };
  };
}
