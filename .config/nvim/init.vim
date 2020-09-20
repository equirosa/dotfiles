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
colorscheme gruvbox
set noshowmode
let g:lightline = {
	\ 'colorscheme': 'gruvbox',
	\ }

" lspconfig stuff
lua require'nvim_lsp'.rnix.setup{}
lua require'nvim_lsp'.jdtls.setup{}

" completion-nvim
autocmd BufEnter * lua require'completion'.on_attach()
"" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
"" Avoid showing message extra message when using completion
set shortmess+=c

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
