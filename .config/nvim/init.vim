set shell=sh
set encoding=utf-8

" Install vim-plug if it isn't already
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-fugitive' " git integration for vim
Plug 'itchyny/lightline.vim' " replace bottom statusline
Plug 'rbgrouleff/bclose.vim' " For use with lf.vim
Plug 'junegunn/goyo.vim'
Plug 'ptzz/lf.vim' " Integration with lf file manager
Plug 'morhetz/gruvbox' " gruvbox colorscheme
Plug 'jiangmiao/auto-pairs' " automatic pairing
Plug 'preservim/nerdcommenter' " Make some commenting easier
" Syntax highlighting
Plug 'dag/vim-fish' " .fish files
Plug 'LnL7/vim-nix' " .nix files
Plug 'ap/vim-css-color' " color previews
Plug 'wlangstroth/vim-racket' " racket
Plug 'vim-scripts/scribble.vim' " scribble
" -- Typescript stuff
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'} " For async completion
Plug 'Shougo/deoplete.nvim' " For Denite features
Plug 'Shougo/denite.nvim'
call plug#end()

set mouse=a
set number relativenumber termguicolors
set splitbelow splitright
syntax enable
set background=dark
let g:gruvbox_material_background = 'hard'
colorscheme gruvbox
set noshowmode
let g:lightline = {
	\ 'colorscheme': 'gruvbox',
	\ }
set tabstop=4
set shiftwidth=4
set noexpandtab
let g:lf_replace_netrw = 1 "open lf when vim open a directory
set colorcolumn=80
autocmd BufWritePost *sway/config,*waybar/* !swaymsg reload
autocmd BufWritePre,FileWritePre *.nix %!nixfmt
autocmd BufWritePre * :%s/\s\+$//e
map <leader>C :w! \| !compiler <c-r>%<CR>
map <C-l> :Lf<CR>
map <C-p> :PlugUpdate<CR>

let g:deoplete#enable_at_startup = 1

" Setting some filetypes
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.guile set filetype=scheme
autocmd BufRead,BufNewFile *.scrbl set filetype=scribble
autocmd BufRead,BufNewFile *lfrc set filetype=conf
