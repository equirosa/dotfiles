" Install vim-plug if it isn't already
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-fugitive' " git integration for vim
Plug 'itchyny/lightline.vim' " replace bottom statusline
Plug 'rbgrouleff/bclose.vim' " For use with lf.vim
Plug 'ptzz/lf.vim' " Integration with lf file manager
Plug 'morhetz/gruvbox' " gruvbox colorscheme
Plug 'preservim/nerdcommenter' " Make some commenting easier
" Syntax highlighting
Plug 'sheerun/vim-polyglot'
Plug 'ap/vim-css-color' " color previews
" completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf.vim'
" Vimwiki
Plug 'vimwiki/vimwiki'
call plug#end()
