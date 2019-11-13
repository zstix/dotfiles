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

set updatetime=300

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

" Display
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'

" Application
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive' " TODO: replace with coc?
Plug 'easymotion/vim-easymotion'
Plug 'ctrlpvim/ctrlp.vim' " TODO: replace with coc?
Plug 'scrooloose/nerdtree'

Plug 'scrooloose/nerdcommenter'

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" TODO: set this up to do the following:
" [x] Prettier
" [x] Completion
" [x] Tooltips
" [x] Go to Definitions
" [ ] Snippets

" Languages
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

call plug#end()

" ----------
" Plugin Configuration
" ----------

" Display
let g:airline_powerline_fonts=1

" Application
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_open_multiple_files = 'ij'
noremap <Leader>p :CtrlPTag<CR>
map <C-n> :NERDTreeToggle<CR>
let g:lt_quickfix_list_toggle_map = '<leader>q'

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

" Languages
let g:javascript_plugin_jsdoc = 1

" ----------
" Colors
" ----------

colorscheme gruvbox

hi Search ctermbg=NONE ctermfg=white cterm=underline