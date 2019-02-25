" Zack Stickles
" 2019

" Load all of the configuration files to create a master
" configuration file.
for f in split(glob('~/.config/nvim/config/*.vim'), '\n')
  exe 'source' f
endfor
