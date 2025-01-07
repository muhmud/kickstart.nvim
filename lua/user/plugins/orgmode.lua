return {
  'nvim-orgmode/orgmode.nvim',
  ft = { 'org' },
  event = 'VeryLazy',
  config = function()
    local orgmode = require 'orgmode'
    orgmode.setup {
      org_blank_before_new_entry = {
        heading = false,
        plain_list_item = false,
      },
    }
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'org',
      callback = function()
        vim.keymap.set('i', '<S-CR>', function()
          require('orgmode').action 'org_mappings.meta_return'
        end, { buffer = true })
        vim.keymap.set('n', '>', function()
          require('orgmode').action 'org_mappings.do_demote'
        end, { buffer = true })
        vim.keymap.set('n', '<', function()
          require('orgmode').action 'org_mappings.do_promote'
        end, { buffer = true })
      end,
    })
  end,
  keys = {
    --{ '<S-CR>', '<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>', desc = 'Org Return', mode = 'i' },
    --{ '>', '<cmd>lua require("orgmode").action("org_mappings.do_demote")<CR>', desc = 'Org Demote', mode = 'n' },
    --{ '<', '<cmd>lua require("orgmode").action("org_mappings.do_promote")<CR>', desc = 'Org Promote', mode = 'n' },
  },
}
