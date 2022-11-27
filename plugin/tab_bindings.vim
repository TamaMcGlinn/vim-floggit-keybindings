
" Tabs
nnoremap <leader>to :tabnew<CR>
nnoremap <leader>tq :tabc<CR>
nnoremap <leader>tw :bp \| bd! #<CR>
nnoremap <leader>t, :call floggit#MoveToPrevTab()<CR>
nnoremap <leader>t. :call floggit#MoveToNextTab()<CR>
nnoremap <leader>th <CR>
nnoremap <leader>tl <CR>

call which_key#add_or_update('t', {'name': '+Tabs',
             \'o': 'New tab',
             \'q': 'Close tab',
             \'w': 'Close and go back',
             \',': 'Move to previous tab',
             \'.': 'Move to next tab',
             \'h': 'Shift tab left',
             \'l': 'Shift tab right',
             \})
