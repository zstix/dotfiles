" ----------
" Plugin Definitions
" ----------

call plug#begin('~/.config/nvim/plugins')

Plug 'arcticicestudio/nord-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Valloric/MatchTagAlways'
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

" vim-airline(-themes)
let g:airline#extensions#tabline#enabled=0
let g:airline#extensions#whitespace#enabled=0
let g:airline_theme='nord'

" MatchTagAlways
let g:mta_filetypes = { 'javascript.jsx': 1 }

" ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
