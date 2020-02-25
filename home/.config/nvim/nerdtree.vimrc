" Toggle NERDTree by using Control-n
map <C-n> :NERDTreeToggle<CR>
" Reveal the current file in NERDTree 
map <leader>r :NERDTreeFind<CR>

" Show line numbers in NERDTree and make sure relative ones are used
let NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber

" Start NERDTree if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close nvim if only NERDTree remains
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
