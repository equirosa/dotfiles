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
        if &shell =~# 'fish$'
          set shell=sh
        endif
        filetype plugin indent on
        set mouse=a
        set number relativenumber termguicolors
        set splitbelow splitright
        syntax enable
        set background=dark
        let g:gruvbox_material_background = 'hard'
        colorscheme gruvbox
        let g:lightline = {
        \ 'colorscheme': 'gruvbox',
        \ }
        set noshowmode
        set tabstop=4
        set shiftwidth=4
        set noexpandtab
        let g:lf_replace_netrw = 1 "open lf when vim open a directory
        set colorcolumn=80
        autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
        autocmd BufRead,BufNewFile *.guile set filetype=scheme
        autocmd BufWritePost *sway/config,*waybar/* !swaymsg reload
        autocmd BufWritePre,FileWritePre *.nix %!nixfmt
        map <leader>C :w! \| !compiler <c-r>%<CR>
        map <C-l> :Lf<CR>
      '';
      plugins = with pkgs.vimPlugins; [
        auto-pairs
        bclose-vim
        fugitive
        goyo
        gruvbox-community
        lf-vim
        nerdcommenter
        lightline-vim
        vim-automkdir
        vim-devicons
        vim-surround
        YouCompleteMe
        # Syntax highlighting
        vim-css-color
        vim-fish
        vim-nix
      ];
      viAlias = true;
      vimAlias = true;
      withPython3 = true;
    };
  };
}
