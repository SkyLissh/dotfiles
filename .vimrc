set number
set mouse=a
set numberwidth=1
set clipboard=unnamedplus
syntax enable
set showcmd
set ruler
set encoding=utf-8
set showmatch
set sw=2
set relativenumber
set laststatus=2
set noshowmode

let g:polyglot_disabled = ['dart', 'jsx', 'tsx']
filetype plugin indent on
set nocompatible

call plug#begin('~/.vim/plugged')

" IDE
Plug 'easymotion/vim-easymotion'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'christoomey/vim-tmux-navigator'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kien/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'

Plug 'dense-analysis/ale'
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}

Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'

Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

" Snippets
Plug 'mlaursen/vim-react-snippets'

" Languages
Plug 'sheerun/vim-polyglot' 
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-rmarkdown'
Plug 'thosakwe/vim-flutter'
Plug 'dart-lang/dart-vim-plugin'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Theme
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'

Plug 'dracula/vim', {'as': 'dracula'}
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'drewtempelmeyer/palenight.vim'
Plug 'arcticicestudio/nord-vim'

Plug 'luochen1990/rainbow'

call plug#end()

" Theming
set termguicolors
let g:dracula_colorterm = 256
" let g:palenight_terminal_italics = 1
colorscheme dracula
hi Normal guibg=NONE ctermbg=NONE 

" \ 'colorscheme': 'darcula',
let g:lightline = {
\ 'colorscheme': 'dracula',
\ 'separator': { 'left': '', 'right': '' },
\ 'subseparator': { 'left': '', 'right': '' }
\ }

let g:rainbow_conf = {
\ 'guifgs': ['#5e81ac', '#8fbcbb', '#81a1c1', '#88c0d0'],
\ 'parentheses': [
\   'start=/{/ end=/}/ fold',
\   'start=/\[/ end=/\]/ fold',
\   'start=/(/ end=/)/ fold',
\   'start=/</ end=/>/ fold'
\ ],
\ 'separately': {
\   '*': {},
\   'css': 0,
\   'html': 0
\ }
\}
let g:rainbow_active = 1
 
:let g:colorizer_auto_color = 1

autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" Shortcuts
let mapleader=" "
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>
nmap <Leader>wq :wq<CR>
nnoremap <A-j> :m .+1<CR>
nnoremap <A-k> :m .-2<CR>
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

nnoremap <F10> :call <SID>SynStack()<CR>
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Easymotion
nmap <Leader>s  <Plug>(easymotion-s2)

" Nerdtree
nmap <Leader>0 :NERDTreeFind<CR>
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1

" Prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#config#print_width = 80
let g:prettier#config#tab_width = 2
let g:prettier#config#use_tabs = 'false'


" CoC
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

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

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Show Definition
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"Toggle Terminal
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

nnoremap <A-t> :call TermToggle(13)<CR>
inoremap <A-t> <Esc>:call TermToggle(13)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(13)<CR>

tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>A

" Bracey
let g:bracey_server_port = 63719

" Emmet 
let g:user_emmet_leader_key = ','

" Dart
let g:dart_format_on_save = 1


" Flutter

" let g:flutter_show_log_on_run = 0

nnoremap <Leader>fa :FlutterRun<CR>
nnoremap <Leader>fq :FlutterQuit<CR>
nnoremap <Leader>fr :FlutterHotReload<CR>
nnoremap <Leader>fR :FLutterHotRestart<CR>
nnoremap <Leader>fD :FlutterVisualDebug<CR>\
