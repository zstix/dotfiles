function! CloseAllBuffersButCurrent()
  let curr = bufnr("%")
  let last = bufnr("$")
  if curr > 1 | silent! execute "1,".(curr-1)."bd" | endif
  if curr < last | silent! execute (curr+1).",".last."bd" | endif
endfunction

nmap <Leader>\c :call CloseAllBuffersButCurrent()<CR>

function! CreateNewTabShell()
  terminal
  startinsert
  setlocal nonumber
endfunction

nmap <Leader>z :call CreateNewTabShell()<CR>source $HOME/.bash_profile<CR>clear<CR>
