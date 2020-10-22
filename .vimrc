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

set fillchars+=vert:│

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

" ----------
" Plugin Definitions
" ----------

call plug#begin('~/.vim/plugged')

" Display
Plug 'itchyny/lightline.vim'
Plug 'dracula/vim', { 'as': 'dracula' }

" Application
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive' " TODO: replace with coc?
Plug 'easymotion/vim-easymotion'
Plug 'ctrlpvim/ctrlp.vim' " TODO: replace with coc?
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ruanyl/vim-gh-line'

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
      \ 'colorscheme': 'ayu_dark',
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
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_open_multiple_files = 'ij'
noremap <Leader>p :CtrlPTag<CR>

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

" Hack to hide lightline in NERDTree
augroup filetype_nerdtree
    au!
    au FileType nerdtree call s:disable_lightline_on_nerdtree()
    au WinEnter,BufWinEnter,TabEnter * call s:disable_lightline_on_nerdtree()
augroup END

fu s:disable_lightline_on_nerdtree() abort
    let nerdtree_winnr = index(map(range(1, winnr('$')), {_,v -> getbufvar(winbufnr(v), '&ft')}), 'nerdtree') + 1
    call timer_start(0, {-> nerdtree_winnr && setwinvar(nerdtree_winnr, '&stl', '%#Normal#')})
endfu

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

" ----------
" Colors
" ----------

set background=dark
colorscheme dracula

set fillchars=vert:\ 

hi Search ctermbg=none ctermfg=white cterm=underline
hi Normal ctermbg=none
hi EndOfBuffer ctermfg=black ctermfg=black
hi VertSplit ctermbg=Black ctermfg=black

hi elixirAlias ctermbg=none ctermfg=cyan
hi elixirModuleDeclaration ctermbg=none ctermfg=cyan
hi type ctermbg=none ctermfg=cyan

hi DraculaGreenItalic cterm=none
hi DraculaOrangeItalic cterm=none