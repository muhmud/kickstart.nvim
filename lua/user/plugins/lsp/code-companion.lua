return {
  'olimorris/codecompanion.nvim',
  opts = {},
  config = function()
    require('codecompanion').setup {
      providers = {
        'copilot',
      },
    }
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
}
