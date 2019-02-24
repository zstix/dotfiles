" Zack Stickles
" 2018

" ----------
" System
" ----------

set nocompatible
set path+=**
set swapfile
set dir=~/.tmp-swp

set nobackup
set nowritebackup

" ----------
" Program
" ----------

let mapleader=","

set history=50
set hidden

set wildmenu
set wildignorecase
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

set confirm
set visualbell
set t_vb= " reset the terminal code for visual bell
set mouse=a

set ruler
set showcmd
set showmode
set laststatus=2 " always show the status line (filename)
set cmdheight=2 " also show the commands (extra line)

set incsearch
set ignorecase
set smartcase
set hlsearch

let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_winsize=25

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

set tabstop=2 " a tab is n spaces
set shiftwidth=2 " auto indent uses n spaces
set smarttab " insert right number of tabs at start of new line
set smartcase " hitting tab will insert spaces
set expandtab " inserts spaces

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

" ----------
" Plugins
" ----------

call plug#begin('~/.vim/plugged')

Plug 'w0rp/ale'
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['eslint']
let g:ale_fix_on_save = 1
hi ALEError ctermbg=black ctermfg=red

Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims=1

Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-fugitive'

Plug 'pangloss/vim-javascript'
let g:javascript_plugin_jsdoc = 1

Plug 'mxw/vim-jsx'

Plug 'Valloric/MatchTagAlways'
let g:mta_filetypes = {
  \ 'javascript.jsx': 1 }

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#whitespace#enabled=0
let g:airline_theme='nord'

Plug 'arcticicestudio/nord-vim'

Plug 'easymotion/vim-easymotion'

Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

Plug 'leafgarland/typescript-vim'

call plug#end()

" ----------
" Colors
" ----------

colorscheme nord

hi Search ctermbg=NONE ctermfg=white cterm=underline
hi VertSplit ctermbg=black ctermfg=black