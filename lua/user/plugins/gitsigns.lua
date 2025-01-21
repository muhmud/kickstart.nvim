return {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = vim.env.NVIM_USE_ICONS == '1' and '➕' or '+' },
      change = { text = vim.env.NVIM_USE_ICONS == '1' and '' or '~' },
      delete = { text = vim.env.NVIM_USE_ICONS == '1' and '❌' or '-' },
      topdelete = { text = vim.env.NVIM_USE_ICONS == '1' and '' or 'x' },
      changedelete = { text = vim.env.NVIM_USE_ICONS == '1' and '' or 'x' },
    },
    status_formatter = function(status)
      -- Icons for Git changes
      local add_icon = vim.env.NVIM_USE_ICONS == '1' and '➕' or '+'
      local change_icon = vim.env.NVIM_USE_ICONS == '1' and ' ' or '~'
      local delete_icon = vim.env.NVIM_USE_ICONS == '1' and '❌' or '-'
      local added = (status.added and status.added > 0) and (add_icon .. status.added) or ''
      local changed = (status.changed and status.changed > 0) and (change_icon .. status.changed) or ''
      local removed = (status.removed and status.removed > 0) and (delete_icon .. status.removed) or ''

      -- Combine changes into a single string
      local changes = table.concat({ added, changed, removed }, ' '):gsub(' +$', '')

      -- Final formatted string
      return changes
    end,
  },
}
