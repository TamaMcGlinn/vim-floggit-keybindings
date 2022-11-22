" cc for commandline, cs for split terminal below,
" windows only: cd for dos terminal, csd for split dos terminal below
if has('win32')
  " Note, you need to empty the file Git\etc\motd
  " to get rid of the 'Welcome to Git' message
  set shell=cmd.exe
  nnoremap <Leader>cc :call termhere#OpenTerminal()<CR>
  nnoremap <Leader>cd :call termhere#OpenDOSTerminal()<CR>
  nnoremap <Leader>csd :call termhere#OpenSplitDOSTerminal()<CR>
else
  nnoremap <Leader>cc :call termhere#OpenTerminal()<CR>
  nnoremap <Leader>cs :call termhere#OpenSplitTerminal()<CR>
endif

fu! Which_key_update(key, dictionary) abort
  if has_key(g:which_key_map, a:key)
    let prior_name = g:which_key_map[a:key]['name']
    let new_name = l:prior_name . '/' . a:dictionary['name'][1:]
    for [new_key, new_value] in items(a:dictionary)
      let g:which_key_map[a:key][new_key] = new_value
    endfor
    let g:which_key_map[a:key]['name'] = l:new_name
  else
    let g:which_key_map[a:key] = a:dictionary
  endif
  call which_key#register('<Space>', 'g:which_key_map')
endfunction

call Which_key_update('c', {'name': '+Terminal',
             \'c': 'Full window',
             \'v': 'Toggleterm',
             \'s': 'Split below',
             \'f': 'relative filename',
             \'F': 'absolute filename',
             \'d': 'DOS CMD',
             \})

nnoremap <Leader>cf :call termhere#UseRelativeFilenameInTermBelow('')<CR>
nnoremap <Leader>cF :call termhere#UseAbsoluteFilenameInTermBelow('')<CR>

