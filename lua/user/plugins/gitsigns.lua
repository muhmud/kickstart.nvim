return {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '➕' },
      change = { text = '' },
      delete = { text = '❌' },
      topdelete = { text = '' },
      changedelete = { text = '' },
    },
    status_formatter = function(status)
      -- Icons for Git changes
      local added = (status.added and status.added > 0) and ('➕' .. status.added) or ''
      local changed = (status.changed and status.changed > 0) and (' ' .. status.changed) or ''
      local removed = (status.removed and status.removed > 0) and ('❌' .. status.removed) or ''

      -- Combine changes into a single string
      local changes = table.concat({ added, changed, removed }, ' '):gsub(' +$', '')

      -- Final formatted string
      return changes
    end,
  },
}
