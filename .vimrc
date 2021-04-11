" Personal .vimrc file
" Author:      Zack Stickles <https://github.com/zstix>
" Last Change: 2020-04-10
" License:     This file is placed in the public domain.

"=================================================
" General
"=================================================

filetype plugin on                  " Load filetype-specific plugins
filetype indent on                  " Load filetype-specific indent files
syntax enable                       " Enable syntax highlighting

set autoread                        " Read when a file has changed from the outside

set path+=**                        " Set the dir for searching for files

set tabstop=2                       " Number of visual spaces per tab
set softtabstop=2                   " Number of spaces in tab when editing
set shiftwidth=2                    " Ensuring that indentation is correct size
set expandtab                       " Tabs are spaces
set smarttab                        " Copy whatever indent format is in the file

set autoindent                      " Copy indent from current line to new line
set smartindent                     " For C-like programs, indent when language-appropriate

set nowrap                          " Don't wrap lines (debatable)
set linebreak                       " Wrap lines without breaking words

set history=500                     " How many lines of history vim remembers

set scrolloff=1                     " Keep a line above and below the cursor

set wildmenu                        " Turn on wildmenu
set wildignorecase                  " Ignore case when searching in the wildmenu
set wildignore=*.so,*.swp,*.zip     " Ignore compiled, svn, junk files, etc.
set wildignore+=*/.git*,*/.DS_Store

set ignorecase                      " Ignore case when searching
set smartcase                       " If you include a capital letter, care about case
set incsearch                       " Show matches while typing a search
set nohlsearch                      " Don't highlight the search term (default)
set magic                           " Turning on regular expressions

set cmdheight=1                     " Height of the command bar
set showcmd                         " Shows (partial) command entry
set noshowmode                      " Hides the mode (represented in the status line

set number                          " Show line numbers
set numberwidth=5                   " Set the gutter width to a fixed size
set signcolumn=yes                  " Show the sign column for errors / git information

set cursorline                      " Show what line the cursor is on
set cursorlineopt=number            " Just modify the number for the cursor line

set hidden                          " A bufffer becomes hidden when it is abandoned

set lazyredraw                      " Don't redraw while executing macros

set showmatch                       " Show matching brackets when cursor over them

set noerrorbells                    " Don't make any sounds
set novisualbell                    " Don't flash the screen on warning
set t_vb=                           " Clear out the visual bell indicator

set encoding=utf-8                  " Set the encoding to something that makes sense

set nobackup                        " Don't back up files, just use svn
set nowritebackup                   " Don't waste time writing backup files
set noswapfile                      " Don't use swap files

set mouse=a                         " Allow the use of the mouse (gasp)

set confirm                         " Confirm whether or not you want to quit unsaved files

set backspace=eol,start,indent      " Make backspace work like it should

set noendofline                     " Don't write anything for the last line of a file

set fillchars+=vert:\               " Set the vertical divider character to a space

"=================================================
" Custom Functions
"=================================================

" Get the git branch name for the current directory
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

" If we're in a repository, return the branch name
function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0 ? '('.l:branchname.') ' : ''
endfunction

"=================================================
" Status line
"=================================================

set laststatus=2                    " Always show status line

set statusline=                     " Clear out any defaults
set statusline+=%#Normal#           " Normal colors (brighter)
set statusline+=[%{mode()}]\        " Current mode
set statusline+=%f\                 " Relative filepath
set statusline+=%{StatuslineGit()}  " Git branch
set statusline+=%#Comment#          " Comment colors (dimmer)
set statusline+=%m\                 " Modified status

set statusline+=%=                  " Left align the next stuff

set statusline+=%y                  " File type
set statusline+=\ %3.3(%p%%%)       " Percent inside file
set statusline+=\ %6(%l:%c%)        " Cursor position

"=================================================
" Plugins
"=================================================

call plug#begin('~/.vim/plugged')

" Application
Plug 'airblade/vim-gitgutter'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree' " TODO: swap out with built-in option
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'

" Language-specific
Plug 'elixir-editors/vim-elixir'
Plug 'hashivim/vim-terraform'
Plug 'jxnblk/vim-mdx-js'
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', {'branch': 'main'}

" coc
" coc-json, coc-tsserver, coc-emmet, coc-snippets, coc-markdown, coc-elixir
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

let NERDTreeShowHidden=1            " Show dotfiles in the file browser
let NERDTreeSortHiddenFirst=1       " Show dotfiles first
let NERDTreeMinimalUI=1             " Disable most of the UI
let NERDTreeWinSize=25              " Set the filebrowser size

"=================================================
" Mappings
"=================================================

" Set leader character to ,
let mapleader=","

" Toggle comments like other editors
nnoremap <C-_> :Commentary<CR>
vnoremap <C-_> :Commentary<CR>

" Easier navigation between buffers
nnoremap <Leader>n :bn<CR>
nnoremap <Leader>p :bp<CR>
nnoremap <Leader><TAB> :bn<CR>

" Toggle spell checking
nnoremap <Leader>ss :setlocal spell!<CR>
nnoremap <Leader>sn ]s
nnoremap <Leader>sp [s
nnoremap <Leader>sa zg
nnoremap <Leader>sr z=

" Move vertically by visual line (for wrapped line)
nnoremap j gj
nnoremap k gk

" Emacs-like (gasp) bindings for command bar
cnoremap <C-A> <HOME>
cnoremap <C-E> <END>
cnoremap <C-K> <C-U>

" Use jk to escape insert mode
inoremap jk <ESC>

" Load the current file
nnoremap <Leader>so :source %<CR>

" Shortcuts to editing configuration files
nnoremap <Leader>vi :sp $MYVIMRC<CR>
nnoremap <Leader>zs :sp ~/.zshrc<CR>
nnoremap <Leader>al :sp ~/.alacritty<CR>

" Use tab (and ahift) to complete popup menu suggestions
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" File browser via
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

"=================================================
" Colors
"=================================================

if exists('+termguicolors')
  set termguicolors
endif

try
  colorscheme onedark
catch
  echo "Missing colorscheme!"
  colorscheme desert
endtry

set background=dark
