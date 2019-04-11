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

" statusline
set laststatus=2
set statusline=
set statusline+=%f
set statusline+=(%{&filetype})
set statusline+=%m
set statusline+=%=
set statusline+=\ %n:
set statusline+=\[%c
set statusline+=:%l/
set statusline+=%L]

" ----------
" Editor
" ----------

set autoindent
set smartindent
set backspace=indent,eol,start
set nostartofline
set nonumber
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
" Plugin Definitions
" ----------

call plug#begin('~/.vim/plugged')

Plug 'arcticicestudio/nord-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'Valloric/MatchTagAlways'
Plug 'easymotion/vim-easymotion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'leafgarland/typescript-vim'

call plug#end()

" ----------
" Plugin Configuration
" ----------

" nerdcommenter
let g:NERDSpaceDelims=1

" ale
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['eslint']
let g:ale_fix_on_save = 1
hi ALEError ctermbg=black ctermfg=red

" vim-javascript
let g:javascript_plugin_jsdoc = 1

" MatchTagAlways
let g:mta_filetypes = { 'javascript.jsx': 1 }

" ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_open_multiple_files = 'ij'
noremap <Leader>p :CtrlPTag<CR>

" ----------
" Colors
" ----------

colorscheme nord

hi Search ctermbg=NONE ctermfg=white cterm=underline
hi VertSplit ctermbg=none ctermfg=none
set fillchars +=vert:\ 

hi StatusLine ctermbg=black ctermfg=white
hi StatusLineNC ctermbg=black ctermfg=gray