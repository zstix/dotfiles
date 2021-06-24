" Personal .vimrc file
" Author:      Zack Stickles <https://github.com/zstix>
" Last Change: 2020-04-14
" License:     This file is placed in the public domain.

"=================================================
" General
"=================================================

set nocompatible                    " Make vim behave like vim, not like vi

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

set wrap                            " Don't wrap lines (default)
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
set matchtime=2                     " Tenths of a second to show the matching bracket

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

let g:netrw_banner=0                " Don't show the banner above file browser
let g:netrw_liststyle=3             " Display file browser as a tree
let g:netrw_browse_split=4          " Open files inprevious window
let g:netrw_altv=1                  " Split to the left
let g:netrw_winsize=25              " File browser takes up 25% of screen

" Turn on spellcheck and disable line numbers for prose-based files
autocmd FileType gitcommit setlocal spell nonumber
autocmd FileType fugitive setlocal spell nonumber
autocmd FileType markdown setlocal spell nonumber
autocmd FileType text setlocal spell nonumber

" Markdown improvements for notes
autocmd FileType markdown syntax match Comment /\%^---\_.\{-}---$/
let g:markdown_fenced_languages = ['javascript', 'elixir', 'sh', 'vim', 'json', 'diff', 'python', 'html', 'jsx']

"=================================================
" Custom Functions
"=================================================

" Get the git branch name for the current directory
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

" Call the function to get the branch _only_ on certain events
augroup gitstatusline
  autocmd!
  autocmd BufEnter,FocusGained,BufWritePost * let b:git_status = GitBranch()
augroup end

" Get the branch name in a pretty format
function! StatuslineGit()
  let l:branchname = get(b:, "git_status", "")
  return strlen(l:branchname) > 0 ? '('.l:branchname.') ' : ''
endfunction

" Show the hover (typescript definition) or relevant help
function! ShowDocumentation()
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! ToggleMarkdownCheckbox()
  let l:prev = getline('.')
  if l:prev =~ '\[x\]'
    let l:next = substitute(l:prev, '\[x\]', '[ ]', '')
  else
    let l:next = substitute(l:prev, '\[ \]', '[x]', '')
  endif
  call setline('.', l:next)
endfunction

"=================================================
" Status line
"=================================================

set laststatus=2                    " Always show status line

set statusline=                     " Clear out any defaults
set statusline+=%#Comment#          " Comment colors (dimmer)
set statusline+=[%{mode()}]\        " Current mode
set statusline+=%#Normal#           " Normal colors (brighter)
set statusline+=%f\                 " Relative filepath
set statusline+=%#Comment#          " Comment colors (dimmer)
set statusline+=%{StatuslineGit()}  " Git branch
set statusline+=%m\                 " Modified status

set statusline+=%=                  " Left align the next stuff

set statusline+=%y                  " File type
set statusline+=\ %4.4(%p%%%)       " Percent inside file
set statusline+=\ %6(%l:%c%)        " Cursor position

"=================================================
" Plugins
"=================================================

call plug#begin('~/.vim/plugged')

" Application
Plug 'airblade/vim-gitgutter'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Language-specific
Plug 'elixir-editors/vim-elixir'
Plug 'hashivim/vim-terraform'
Plug 'jxnblk/vim-mdx-js'
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'
Plug 'othree/jsdoc-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', {'branch': 'main'}

" coc
" coc-json, coc-tsserver, coc-emmet, coc-snippets, coc-markdown, coc-elixir
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"=================================================
" Mappings
"=================================================

" Set leader character to ,
let mapleader=","

" Toggle comments like other editors
nnoremap <Leader>c<SPACE> :Comment<CR>
vnoremap <Leader>c<SPACE> :Comment<CR>
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
nnoremap <Leader>sl 1z=

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
nnoremap <Leader>al :sp ~/.alacritty.yml<CR>

" Use tab (and ahift) to complete popup menu suggestions
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" File browser via netrw
nnoremap <C-N> :Lexplore<CR>

" Show help
nnoremap <silent>K :call ShowDocumentation()<CR>

" Fuzzyfind files
nnoremap <C-P> :GFiles<CR>
nnoremap <C-G> :Ag<CR>

" Open Github to the current file
nnoremap <Leader>gh :Gbrowse<CR>

" Better file navigation with coc
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gy <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)

" Toggle markdown checkboxes
nnoremap <Leader>cc :call ToggleMarkdownCheckbox()<CR>

"=================================================
" Colors
"=================================================

" Set colors to GUI colors, if available
if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Fix for italics in tmux
set t_ZH=[3m
set t_ZR=[3m

" Set the colorscheme (with a better fallback)
try
  colorscheme dracula
catch
  echo "Missing colorscheme!"
  colorscheme desert
endtry

" Set the background to dark (for colorscheme) and transparent
set background=dark
hi Normal guibg=NONE

" Set fzf colors to match the current colorscheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
