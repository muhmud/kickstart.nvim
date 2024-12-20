return {
  -- Extends % to language specific keywords
  'andymass/vim-matchup',
  lazy = false,
  init = function()
    vim.g.matchup_matchparen_offscreen = { method = 'popup' }
  end,
}
