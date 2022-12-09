" Add the dictionary to the specified key if nothing currently mapped,
" otherwise add to the dict already mapped, adding /new_name onto the name.
" E.g. one file could map '+Terminal' on the t key, and then another file
" or plugin could use the same t for tab control, and if both files are loaded
" you get +Terminal/Tab with both mappings. If items overlap, the second
" loaded overrides the first.
function! floggit#update_whichkey(key, dictionary) abort
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

" from https://vim.fandom.com/wiki/Move_current_window_between_tabs

function! floggit#MoveToPrevTab() abort
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    split
  else
    close!
    exe '0tabnew'
  endif
  "opening current buffer in new window
  exe 'b'.l:cur_buf
endfunc

function! floggit#MoveToNextTab() abort
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    split
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe 'b'.l:cur_buf
endfunc

function! floggit#TabClose() abort
  " Check if current tab is last tab
  " https://vi.stackexchange.com/questions/36464/how-to-check-if-the-current-tab-is-the-last-tab
  if tabpagenr() == tabpagenr('$')
    quit
  else
    execute "tabc"
  endif
endfunction

function! floggit#open_flog() abort
  if exists("*autoflog#open_flog()")
    call autoflog#open_flog()
  elseif exists("*flogmenu#open_git_log()")
    " TODO this fallback doesn't work; find out why
    " the exists call returns 0 until you have sourced the flogmenu.vim file
    call flogmenu#open_git_log()
  else
    execute ':Flog -all'
  endif
endfunction

