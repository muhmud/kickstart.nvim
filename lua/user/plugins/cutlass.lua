return {
  -- Use the blackhole register c, d, and x
  'svermeulen/vim-cutlass',
  lazy = false,
  keys = {
    { 'm', 'd' },
    { 'm', 'd', mode = 'x' },
    { 'mm', 'dd' },
    { 'M', 'D' },
    { 'gm', 'm' },
  },
}
