" Sourcing
so ~/.config/nvim/coc/general.vim " CoC
so ~/.config/nvim/plug.vim " Plug

set shell=sh
set encoding=utf-8
set wrap linebreak
set undodir=~/.local/share/nvim/undodir
set undofile

nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
nmap <silent> <A-k> :wincmd k<CR>
nmap <silent> <A-h> :wincmd h<CR>
nmap <silent> <A-j> :wincmd j<CR>
nmap <silent> <A-l> :wincmd l<CR>

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
autocmd BufWritePre * :%s/\s\+$//e " Remove whitespace upon saving a file
map <leader>C :w! \| !compiler <c-r>%<CR>
map <C-z> :Lf<CR>
map <C-p> :PlugUpdate<CR>

" Setting some filetypes
"autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
"autocmd BufRead,BufNewFile *.guile set filetype=scheme
"autocmd BufRead,BufNewFile *.scrbl set filetype=scribble
"autocmd BufRead,BufNewFile *lfrc,*sway/* set filetype=conf
"autocmd BufRead,BufNewFile *.md set filetype=markdown
