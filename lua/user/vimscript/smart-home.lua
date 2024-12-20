vim.cmd [[
  function! ToggleWrap()
    let wrap=&wrap
    if wrap == "nowrap"
      normal :set wrap linebreak
    else
      normal :set wrap nowrap
    end
  endfunction

  function! SmartHome()
    let line = getline('.')
    let curcol = col(".")
    let hatcol = match(line, '\S') + 1
    if curcol == 1 || hatcol != curcol
      normal ^
    else
      call cursor(line, 1)
    end
  endfunction
]]
