return {
  'nvim-tree/nvim-tree.lua',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local function nvimtree_on_attach(bufnr)
      local api = require 'nvim-tree.api'

      local function resize_up(_)
        vim.cmd [[ NvimTreeResize +1 ]]
      end

      local function resize_down(_)
        vim.cmd [[ NvimTreeResize -1 ]]
      end

      local function close(_)
        vim.cmd [[ NvimTreeClose ]]
      end

      api.config.mappings.default_on_attach(bufnr)

      vim.keymap.set('n', 'l', api.node.open.edit, { buffer = bufnr })
      vim.keymap.set('n', 'o', api.node.open.edit, { buffer = bufnr })
      vim.keymap.set('n', '<cr>', api.node.open.edit, { buffer = bufnr })
      vim.keymap.set('n', 'v', api.node.open.vertical, { buffer = bufnr })
      vim.keymap.set('n', 'h', api.node.navigate.parent_close, { buffer = bufnr })
      vim.keymap.set('n', 'C', api.tree.change_root_to_node, { buffer = bufnr })
      vim.keymap.set('n', '<M-h>', resize_up, { buffer = bufnr })
      vim.keymap.set('n', '<M-l>', resize_down, { buffer = bufnr })
      vim.keymap.set('n', '<esc><esc>', close, { buffer = bufnr })
    end

    require('nvim-tree').setup {
      on_attach = nvimtree_on_attach,
      view = {
        side = 'right',
        width = 70,
      },
      update_focused_file = {
        enable = true,
        update_root = {
          enable = true,
          ignore_list = {},
        },
        exclude = false,
      },
    }
  end,
  keys = {
    { '<leader>e', '<cmd>NvimTreeFocus<cr>', desc = '[E]xplorer' },
    { '<leader>o', '<C-W><C-W>', desc = '[O]ther window' },
  },
}
