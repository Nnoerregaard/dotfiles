let mapleader=","
let maplocalleader="\\"

" if empty(glob('~/.vim/autoload/plug.vim'))
"  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"endif

call plug#begin('~/.vim/plugged')
" The left sidebar
Plug 'scrooloose/nerdtree'
" For projectwide search, fuzzy finding of files project-wide ect.
Plug 'Shougo/denite.nvim'
" The search engine itself. NB! Requires 'the_silver_searcher to be installed
" (see GitHub Repo)
Plug 'mileszs/ack.vim'
" Autocomplete, linting through eslint (including prettyfier) and other
" languageserver features
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" This is used for syntax highlighting see: https://github.com/peitalin/vim-jsx-typescript
Plug 'leafgarland/typescript-vim' 
Plug 'maxmellon/vim-jsx-pretty'
" The color scheme I currently use
Plug 'dikiaap/minimalist'
" Ultisnips for snippets
Plug 'SirVer/ultisnips'
" Debugging
Plug 'puremourning/vimspector'
" Syntax highlighting for vue
Plug 'posva/vim-vue'
" For pug support (syntax highlighting and indentation)
Plug 'digitaltoad/vim-pug'
" Tmux config file syntax highlighting
Plug 'tmux-plugins/vim-tmux'

filetype plugin indent on
"TODO: Customizing syntax highlighting

" autocmd BufRead *.tsx set syntax=typescript
call plug#end()

" Use another expand trigger than tab as that is for  
" let g:UltiSnipsExpandTrigger='<c-tab>'

" Debugger - Customize later!
let g:vimspector_enable_mappings = 'HUMAN'

" Enable deoplete at startup
" let g:deoplete#enable_at_startup = 1

" Define mappings for denite
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight
let s:denite_options = {'default' : {
\ 'auto_resize': 1,
\ 'prompt': 'λ:',
\ 'direction': 'rightbelow',
\ 'winminheight': '10',
\ 'highlight_mode_insert': 'Visual',
\ 'highlight_mode_normal': 'Visual',
\ 'prompt_highlight': 'Function',
\ 'highlight_matched_char': 'Function',
\ 'highlight_matched_range': 'Normal'
\ }}

" Define file/rec such that for git repos we use git ls-files
call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command',
\ ['git', 'ls-files', '-co', '--exclude-standard'])

" Using Ack with vim with ag as the underline search engine
"
let g:ackprg = 'ag --vimgrep --smart-case'                                                   
cnoreabbrev ag Ack                                                                           
cnoreabbrev aG Ack                                                                           
cnoreabbrev Ag Ack                                                                           
cnoreabbrev AG Ack

" Change file/rec for ag
call denite#custom#var('file/rec/ordinary', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

" Ag command on grep source
call denite#custom#var('grep', {
\ 'command': ['ag'],
\ 'default_opts': ['-i'],
\ 'recursive_opts': [],
\ 'pattern_opt': [],
\ 'separator': ['--'],
\ 'final_opts': [],
\ })

nmap g; :Denite buffer -split=floating -winrow=1<CR>
" nmap gp :Denite `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'` -split=floating -winrow=1<CR>i
nmap gp :Denite `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'` -split=floating -winrow=1<CR>i
nnoremap <silent> <C-p> :<C-u>Denite `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'` 
\<CR>
nnoremap gf :<C-u>Denite grep:. -no-empty<CR>
nnoremap gw :<C-u>DeniteCursorWord grep:.<CR>

colorscheme minimalist

let g:coc_global_extensions = [ 'coc-omnisharp', 'coc-tsserver', 'coc-eslint', 'coc-vetur' ]

""DEPENDENCIES
"source ~/.config/nvim/plugins.vim
source ~/.config/nvim/nerdtree.vimrc
"source ~/.config/nvim/typescript.vimrc
"source ~/.config/nvim/utils.vim
"source ~/.config/nvim/navigation.vim
"source ~/.config/nvim/keybinds.vim
" if hidden is not set, TextEdit might fail.
set hidden

set autoread

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <silent><expr> <C-l>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<C-l>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<C-n>'

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" use `:RNF` (rename file) for renaming the file in the current buffer
command! -nargs=0 RNF   :call     CocAction('runCommand', 'workspace.renameCurrentFile')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Prettier (used for json, javascript ect. For ts and tsx files, prettier
" through eslint is being used 
command! -nargs=0 Prettify :CocCommand prettier.formatFile

" personilzation here
set nowrap
set shiftround
set expandtab
set tabstop=2 
set shiftwidth=2

set autoread
set statusline="%f%m%r%h%w [%Y] [0x%02.2B]%< %F%=%4v,%4l %3p%% of %L"

set number
set splitbelow
let g:syntastic_typescript_checkers = ['tslint', 'tsc']
let g:syntastic_cs_checkers = ['code_checker']
let g:rustfmt_autosave = 1

" Clear highlighting after search
:nnoremap <leader>c :noh<CR>

" Use + and - to move codelines up and down - I don't use + and - default
" functionality anyway so skip leader to make them faster and easier to use
:nnoremap + ddp
:nnoremap - ddkP

" Make newlines without entering insert mode
:nnoremap <leader>o o<esc>
:nnoremap <leader>O O<esc> 

" Make working with windows easier  <Ctrl>ws
" :nnoremap <leader>| :wimcmd s<CR>
:nnoremap <leader><Bar> :wincmd v<CR>
:nnoremap <leader>_ :wincmd s<CR>
:nnoremap <leader>x :wincmd q<CR>
:nnoremap <leader>= :wincmd =<CR>
:nnoremap <leader>w :wincmd w<CR>
:nnoremap <leader>h :wincmd h<CR>
:nnoremap <leader>l :wincmd l<CR>
:nnoremap <leader>j :wincmd j<CR>
:nnoremap <leader>k :wincmd k<CR>


" Easy copy to clipboard 
:nnoremap cy "*y
:nnoremap cyy "*yy
:nnoremap cY "*Y
:nnoremap cp "*p
:nnoremap cP "*P

" Easy save
:nnoremap <leader>s :w<CR>

" Upper case in insert mode and normal mode
:inoremap <leader>u <esc>lviwUEa<space>
:nnoremap <leader>u viwUE<esc>

" Allow for easy edition of this file
:nnoremap <leader>ei :split $MYVIMRC<cr>
:nnoremap <leader>si :source $MYVIMRC<cr>

" Put quotes around words and selection
:nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
:nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
:vnoremap <leader>' <esc>`<i'<esc>`>a'
:vnoremap <leader>" <esc>`<i"<esc>`>a"

" Easier switching back and forth between buffers 
:nnoremap <leader>n :bn<CR>
:nnoremap <leader>p :bp<CR>

" Easier access to normal mode
:inoremap jk <esc>
:inoremap <esc> <nop>

" Disable keys that I should not be using
:nnoremap <left> <nop>
:nnoremap <right> <nop>
:nnoremap <up> <nop>
:nnoremap <down> <nop>

:inoremap <left> <nop>
:inoremap <right> <nop>
:inoremap <up> <nop>
:inoremap <down> <nop>
:inoremap <bs> <nop>

" Autocommands to set filetypes
:autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
:autocmd BufNewFile,BufRead *.ts set filetype=typescript

" Autocommands for specific filetypes
:autocmd FileType tsx nnoremap <buffer> <localleader>c I//<space>
:autocmd FileType tsx nnoremap <buffer> <localleader>mc I/*<space>
:autocmd FileType tsx nnoremap <buffer> <localleader>xc I{/*<space>

" Abbreviations
:iabbrev co const
:iabbrev im import
