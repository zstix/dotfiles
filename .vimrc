" Zack Stickles
" 2017

" ----------
" System
" Stuff that vim needs to run on the system correctly
" ----------

set nocompatible
set path+=** " search down into subfolders
set tags+=.git/tags

" ----------
" Editor
" Stuff that alters the editing process
" ----------

set autoindent
set smartindent
set backspace=indent,eol,start
set nostartofline
set number
set showmatch
syntax on

set tabstop=2 " a tab is n spaces
set shiftwidth=2 " auto indent uses n spaces
set smarttab " insert right number of tabs at start of new line
set smartcase " hitting tab will insert spaces
set expandtab " inserts spaces

set foldmethod=indent
set foldlevelstart=20

" ----------
" Program
" Stuff that impacts the 'GUI' of vim
" ----------

set history=50
set hidden
set wildmenu
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
set ignorecase " case insensitive
set smartcase " ^ unless specified
set nohls

" ----------
"  Colors
"  Make the editor and program look pretty
"  [work in progress]
" ----------

hi LineNr ctermfg=DarkCyan
hi PmenuSel ctermbg=white ctermfg=black
hi Pmenu ctermbg=black ctermfg=white
hi MatchParen ctermbg=black ctermfg=white
hi VertSplit ctermfg=black ctermbg=black
hi StatusLineNC ctermbg=white ctermfg=black
hi StatusLine ctermfg=DarkCyan
hi TabLineFill ctermfg=black
hi TabLine ctermbg=black ctermfg=DarkCyan
