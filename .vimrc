" Zack Stickles
" 2019

" ----------
" System
" ----------

set nocompatible
set path+=**
set swapfile
set dir=~/.tmp-swp

set nobackup
set nowritebackup

set encoding=UTF-8

" ----------
" Program
" ----------

let mapleader=","

set history=50
set hidden

set wildmenu
set wildignorecase
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe

set confirm
set visualbell
set t_vb=
set mouse=a

set ruler
set showcmd
set showmode
set cmdheight=1

set incsearch
set ignorecase
set smartcase
set hlsearch

let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_winsize=25

augroup CursorLine
  au!
  au VimEnter * setlocal cursorline
  au WinEnter * setlocal cursorline
  au BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

inoremap <C-c> <Esc>

set updatetime=300

" set fillchars+=vert:│
set fillchars+=vert:\ 
set numberwidth=5

" map <C-i> :terminal ++curwin<CR>
:set noshowmode

" ----------
" Editor
" ----------

set autoindent
set smartindent
set backspace=indent,eol,start
set nostartofline
set number
set showmatch
set cursorline
syntax on

set noeol
set binary

set tabstop=2
set shiftwidth=2
set smarttab
set smartcase
set expandtab

" ----------
" Functions
" ----------

function! CloseAllBuffersButCurrent()
  let curr = bufnr("%")
  let last = bufnr("$")
  if curr > 1 | silent! execute "1,".(curr-1)."bd" | endif
  if curr < last | silent! execute (curr+1).",".last."bd" | endif
endfunction

nmap <Leader>\c :call CloseAllBuffersButCurrent()<CR>

function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nmap <leader>sp :call <SID>SynStack()<CR>

function! MyFoldText()
  let line = getline(v:foldstart)
  let folded_line_num = v:foldend - v:foldstart
  return '[+] ' . line . ' (' . folded_line_num . ' L)'
endfunction

set foldtext=MyFoldText()
set fillchars=fold:\ 

" ----------
" Plugin Definitions
" ----------

call plug#begin('~/.vim/plugged')

" Display
Plug 'itchyny/lightline.vim'
Plug 'cocopon/iceberg.vim'

" Application
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive' " TODO: replace with coc?
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ruanyl/vim-gh-line'
Plug 'Yggdroot/indentLine'

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Manage with :CocList extensions (search, tab, action)
" coc-json
" coc-tsserver
" coc-emmet
" coc-snippets
" coc-markdown
" coc-elixir

" Languages
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'hashivim/vim-terraform'
Plug 'jxnblk/vim-mdx-js'
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'styled-components/vim-styled-components', {'branch': 'main'}

" Misc
Plug 'ryanoasis/vim-devicons'

call plug#end()

" ----------
" Plugin Configuration
" ----------

" Display
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'iceberg',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \      [ 'gitbranch', 'readonly', 'filename', 'modified'] ],
      \   'right': [[ 'lineinfo' ], ['filetype', 'percent']],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'filetype': 'MyFiletype',
      \ },
      \ }

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

" Application
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_open_multiple_files = 'ij'

let g:gh_open_command = 'fn() { echo "$@" | pbcopy; }; fn '

map <C-n> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>
let g:lt_quickfix_list_toggle_map = '<leader>q'
let NERDSpaceDelims=1
let NERDTreeSortHiddenFirst=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let g:NERDTreeDirArrowExpandable=''
let g:NERDTreeDirArrowCollapsible=''
let g:NERDTreeWinSize=25

let g:indentLine_char='│'

set signcolumn=yes
let g:gitgutter_sign_added = '▌'
let g:gitgutter_sign_modified = '▌'
let g:gitgutter_sign_removed = '▌'
let g:gitgutter_sign_removed_first_line = '▌'
let g:gitgutter_sign_removed_above_and_below = '▌'
let g:gitgutter_sign_modified_removed = '▌'

" coc (additional config in .vim/coc-setting.json)
command! -nargs=0 Prettier :CocCommand prettier.formatFile

inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

imap <C-l> <Plug>(coc-snippets-expand)
imap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
imap <C-j> <Plug>(coc-snippets-jump)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Languages
let g:javascript_plugin_jsdoc = 1

let g:mix_format_on_save = 1

let g:fzf_layout = { 'down': '40%' }
map <C-P> :GFiles<CR>
map <C-g> :Ag<CR>

" ----------
" Colors
" ----------

if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set background=dark
colorscheme iceberg

hi Normal guibg=NONE
hi LineNr guibg=NONE
hi SignColumn guibg=NONE
hi GitGutterAdd guibg=NONE
hi GitGutterChange guibg=NONE
hi GitGutterChangeDelete guibg=NONE
hi GitGutterDelete guibg=NONE
hi EndOfBuffer guibg=NONE
hi VertSplit term=NONE guifg=NONE guibg=NONE
hi CursorLineNr guibg=NONE

hi Search cterm=underline guibg=NONE guifg=white

let g:fzf_colors = {
\ 'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\ 'bg+': ['bg', 'CursorLine', 'CursorColumn'],
\ }