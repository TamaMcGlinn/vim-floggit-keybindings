lua require("telescope").load_extension("git_worktree")
lua require('worktree_config')

fu! Create_Worktree() abort
  silent execute 'Gcd'
  " lua require('git-worktree')._find_git_root_job()
  let l:worktree_name = input('> ')
  call v:lua.require('git-worktree').create_worktree(l:worktree_name, l:worktree_name)
endfunction

fu! Switch_Worktree() abort
  silent execute 'Gcd'
  lua << EOF
  --local linenr = vim.api.nvim_win_get_cursor(0)[1]
  local Worktree = require("git-worktree")
  --Worktree._find_git_root_job()
  require('telescope').extensions.git_worktree.git_worktrees()
  --Worktree.on_tree_update(function(op, metadata)
  --  vim.cmd('execute "normal! ' .. linenr .. 'G"')
  --end)
EOF
endfunction

fu! Get_Current_File_Contents() abort
  if &fileformat == 'unix'
      let line_ending = "\n"
  elseif &fileformat == 'dos'
      let line_ending = "\r\n"
  elseif &fileformat == 'mac'
      let line_ending = "\r"
  else
      throw "unknown value for the 'fileformat' setting: " . &fileformat
  endif
  let l:text = join(getline(1, '$'), line_ending).line_ending
  let g:file_contents = l:text
  " return l:text
endfunction

let g:file_contents = ''

fu! Replace_File_Contents() abort
  " A horrible hack! because I couldn't be bothered
  " passing parameters from viml to lua and back
  l:new_contents = g:file_contents
  " add output on top
  call append(0, l:new_contents)
  " delete the rest
  call deletebufline("%", len(l:new_contents) + 1, "$")
endfunction

fu! Switch_And_Paste() abort
  " let l:contents = Get_Current_File_Contents()
  call Get_Current_File_Contents()
  lua << EOF
  local Worktree = require("git-worktree")
  Worktree.on_tree_update(function(op, metadata)
    vim.cmd('call Replace_File_Contents()')
  end)
EOF
  call Switch_Worktree()
  " call Replace_File_Contents(l:contents)
endfunction
