" double escape clears search highlight
nno <esc><esc> :nohlsearch<cr>

" open directory of current file / terminal line
nnoremap <silent> - :call browsedir#BrowseDir()<CR>
