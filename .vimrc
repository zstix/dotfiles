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
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

set confirm
set visualbell
set t_vb= " reset the terminal code for visual bell
set mouse=a

set ruler
set showcmd
set showmode
set cmdheight=2

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
Plug 'peitalin/vim-jsx-typescript'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'

Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'

Plug 'roxma/vim-hug-neovim-rpc'
Plug 'Valloric/ListToggle'
Plug 'morhetz/gruvbox'
Plug 'mhinz/vim-startify'

" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" TODO: install and setup https://github.com/sirver/UltiSnips
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'

call plug#end()

" ----------
" Plugin Configuration
" ----------

" nerdcommenter
let g:NERDSpaceDelims=1

" ale
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier', 'eslint']
let g:ale_fixers['typescript'] = ['prettier', 'eslint']
let g:ale_fix_on_save = 1
hi ALEError ctermbg=black ctermfg=red

let g:ale_linters = {}
let g:ale_linters['typescript'] = ['eslint', 'tsserver']

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

" vim-airline
let g:airline_powerline_fonts=1

" nerdtree
map <C-n> :NERDTreeToggle<CR>

" deoplete
let g:deoplete#enable_at_startup=1
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" ListToggle
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'

" Sartify
let g:startify_custom_header = ['New Relic', 'Zack Stickles']

" ----------
" Colors
" ----------

colorscheme gruvbox

" hi Search ctermbg=NONE ctermfg=white cterm=underline
" hi VertSplit ctermbg=none ctermfg=8
" set fillchars+=vert:│

" hi StatusLine ctermbg=NONE ctermfg=white
" hi StatusLineNC ctermbg=NONE ctermfg=gray

" hi CursorLineNr cterm=none

" hi Comment ctermfg=gray