set hidden nobackup nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" CoC extensions
let g:coc_global_extensions = [
			\'coc-tsserver',
			\'coc-json',
			\'coc-css',
			\'coc-yaml',
			\'coc-explorer',
			\'coc-prettier',
			\'coc-snippets',
			\'coc-rls'
			\]
so ~/.config/nvim/coc/extensions/prettier.vim
