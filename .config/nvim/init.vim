" Sourcing
"so ~/.config/nvim/coc/general.vim " CoC

set shell=sh
set encoding=utf-8
set wrap linebreak
set undodir=~/.local/share/nvim/undodir
set undofile
set mouse=a
set number relativenumber termguicolors
set splitbelow splitright
syntax enable

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
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'junegunn/fzf.vim'
" Vimwiki
Plug 'vimwiki/vimwiki'
call plug#end()

nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
nmap <silent> <A-k> :wincmd k<CR>
nmap <silent> <A-h> :wincmd h<CR>
nmap <silent> <A-j> :wincmd j<CR>
nmap <silent> <A-l> :wincmd l<CR>

" Theming
set background=dark
let g:gruvbox_material_background = 'hard'
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
colorscheme gruvbox
set noshowmode
let g:lightline = {
	\ 'colorscheme': 'gruvbox',
	\ }
set tabstop=4
set shiftwidth=4
set noexpandtab
let g:lf_replace_netrw = 1 "open lf when vim open a directory
let g:vimwiki_global_ext = 0 " prevent vimwiki from overriding filetypes
set colorcolumn=80
autocmd BufWritePost *sway/config,*waybar/*,status.toml !swaymsg reload
autocmd BufWritePre * :%s/\s\+$//e " Remove whitespace upon saving a file
map <leader>C :w! \| !compiler <c-r>%<CR>
map <C-z> :Lf<CR>
map <C-p> :PlugUpdate<CR>

