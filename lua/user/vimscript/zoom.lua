vim.cmd [[
  let g:original_guifont=&guifont

  function! ZoomIn()
    let font = substitute(&guifont, '\(.*\):h[0-9]\+$', '\1', 'g')
    let size = str2nr(substitute(&guifont, '.*:h\([0-9]\+\)$', '\1', 'g'))
    let size += 1

    let &guifont=font .. ":h" .. size
  endfunction

  function! ZoomOut()
    let font = substitute(&guifont, '\(.*\):h[0-9]\+$', '\1', 'g')
    let size = str2nr(substitute(&guifont, '.*:h\([0-9]\+\)$', '\1', 'g'))
    let size -= 1

    if size > 0
      let &guifont=font .. ":h" .. size
    end
  endfunction

  function! ZoomReset()
    let &guifont=g:original_guifont
  endfunction
]]
