{ config, pkgs, ...}: {
  environment = {
    shellAliases = {
      vi="vim";
    };
    variables = {
      EDITOR = "vim";
    };
  };
  home-manager.users.eduardo = { pkgs, ...}: {
    programs.vim = {
      enable = true;
      extraConfig = ''
        filetype plugin indent on
        syntax enable
        colorscheme gruvbox
        let g:airline_theme = 'gruvbox' 
        set colorcolumn=80
        highlight ColorColumn ctermbg=1
        autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
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
