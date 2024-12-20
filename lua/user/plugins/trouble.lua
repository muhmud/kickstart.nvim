return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  config = function()
    require('trouble').setup {
      action_keys = {
        jump = { 'o', '<tab>' },
        jump_close = { '<cr>' },
      },
    }
  end,
}
