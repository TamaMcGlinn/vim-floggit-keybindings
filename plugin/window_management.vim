function! TabIsEmpty() abort
    " Remember which window we're in at the moment
    let initial_win_num = winnr()

    let win_count = 0
    " Add the length of the file name on to count:
    " this will be 0 if there is no file name
    windo let win_count += len(expand('%'))

    " Go back to the initial window
    exe initial_win_num . "wincmd w"

    " Check count
    if win_count == 0
        " Tab page is empty
        return 1
    else
        return 0
    endif
endfunction

" Tab movement
nnoremap <Leader>h :tabp<CR>
nnoremap <Leader>l :tabn<CR>

let g:which_key_map['h'] = 'Previous tab'
let g:which_key_map['l'] = 'Next tab'

" Make the split taller
nnoremap <Leader>bb 8<C-W>+<CR>
nnoremap <Leader>bB 24<C-W>+<CR>
" Make the split wider
nnoremap <Leader>bw 24<C-W>><CR>
nnoremap <Leader>bW 50<C-W>><CR>

let g:which_key_map['b'] = {'name': '+BiggerSplit',
             \'b': 'taller',
             \'B': 'much taller',
             \'w': 'wider',
             \'W': 'much wider',
             \}
