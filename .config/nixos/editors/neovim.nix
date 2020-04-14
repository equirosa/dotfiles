{ config, pkgs, ... }: {
  environment = {
    shellAliases = {
      v = "nvim";
      vi = "nvim";
      vim = "nvim";
      vimdiff = "nvim -d";
    };
  };
  home-manager.users.eduardo = { pkgs, ... }: {
    programs.neovim = {
      enable = true;
      extraConfig = ''
        filetype plugin indent on
        set number relativenumber termguicolors
        set splitbelow splitright
        syntax enable
        set background=dark
        let g:gruvbox_material_background = 'hard'
        colorscheme gruvbox
        let g:airline_theme = 'gruvbox'
        set tabstop=4
        set shiftwidth=4
        set noexpandtab
        let g:lf_replace_netrw = 1 "open lf when vim open a directory
        set colorcolumn=80
        autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
        autocmd BufWritePost *sway/config,*waybar/* !swaymsg reload
        autocmd BufWritePre,FileWritePre *.nix %!nixfmt
        map <leader>C :w! \| !compiler <c-r>%<CR>
      '';
      plugins = with pkgs.vimPlugins; [
        auto-pairs
        bclose-vim
        fugitive
        goyo
        gruvbox-community
        lf-vim
        nerdcommenter
        vim-airline
        vim-airline-themes
        vim-automkdir
        vim-css-color
        vim-devicons
        vim-nix
        vim-surround
        YouCompleteMe
      ];
      viAlias = true;
      vimAlias = true;
      withPython3 = true;
    };
  };
}
