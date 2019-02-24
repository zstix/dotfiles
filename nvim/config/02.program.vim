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

" Oni-specific settings
if exists('g:gui_oni')
  set laststatus=1
  set cmdheight=1
endif
