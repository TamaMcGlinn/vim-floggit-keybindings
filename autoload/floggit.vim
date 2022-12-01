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

