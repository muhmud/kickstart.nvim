return {
  'folke/snacks.nvim',
  opts = {
    lazygit = {},
  },
  keys = {
    { '<leader>gd', '<cmd>lua Snacks.lazygit()<cr>', desc = '[G]it [D]ashboard' },
  },
}
