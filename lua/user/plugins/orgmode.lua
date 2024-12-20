return {
  'nvim-orgmode/orgmode.nvim',
  config = function()
    local orgmode = require 'orgmode'
    orgmode.setup {
      org_blank_before_new_entry = {
        heading = false,
        plain_list_item = false,
      },
    }
  end,
}
