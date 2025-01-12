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

      local function start_telescope(telescope_mode)
        local node = api.tree.get_node_at_cursor()
        if node ~= nil then
          local abspath = node.link_to or node.absolute_path
          local is_folder = node.open ~= nil
          local basedir = is_folder and abspath or vim.fn.fnamemodify(abspath, ':h')
          require('telescope.builtin')[telescope_mode] {
            cwd = basedir,
          }
        end
      end

      local function telescope_find_files(_)
        start_telescope 'find_files'
      end

      local function telescope_live_grep(_)
        start_telescope 'live_grep'
      end

      local function get_node_at_cursor()
        local core = require 'nvim-tree.core'
        local view = require 'nvim-tree.view'

        if not core.get_explorer() then
          return
        end

        local winnr = view.get_winnr()
        if not winnr then
          return
        end

        local cursor = vim.api.nvim_win_get_cursor(winnr)
        local line = cursor[1]

        if line == 1 and view.is_root_folder_visible(core.get_cwd()) then
          return { name = '..' }
        end

        return require('nvim-tree.utils').get_nodes_by_line(core.get_explorer().nodes, core.get_nodes_starting_line())[line]
      end

      local function get_git_root()
        local git_dir = vim.fn.finddir('.git', vim.fn.expand '%:p:h' .. ';')
        return vim.fn.fnamemodify(git_dir, ':h')
      end

      local function goto_git_root()
        local git_root = get_git_root()
        if git_root then
          local node = get_node_at_cursor()
          api.tree.change_root(git_root)
          api.tree.find_file(node.absolute_path, true)
        end
      end

      api.config.mappings.default_on_attach(bufnr)

      vim.keymap.set('n', 'l', api.node.open.edit, { buffer = bufnr })
      vim.keymap.set('n', 'o', api.node.open.edit, { buffer = bufnr })
      vim.keymap.set('n', '<cr>', api.node.open.edit, { buffer = bufnr })
      vim.keymap.set('n', 'v', api.node.open.vertical, { buffer = bufnr })
      vim.keymap.set('n', 'h', api.node.navigate.parent_close, { buffer = bufnr })
      vim.keymap.set('n', 'C', api.tree.change_root_to_node, { buffer = bufnr })
      vim.keymap.set('n', 'V', goto_git_root, { buffer = bufnr })
      vim.keymap.set('n', '<M-h>', resize_up, { buffer = bufnr })
      vim.keymap.set('n', '<M-l>', resize_down, { buffer = bufnr })
      vim.keymap.set('n', '<esc><esc>', close, { buffer = bufnr })
      vim.keymap.set('n', 's', telescope_live_grep, { buffer = bufnr })
      vim.keymap.set('n', 'f', telescope_find_files, { buffer = bufnr })
    end

    require('nvim-tree').setup {
      on_attach = nvimtree_on_attach,
      respect_buf_cwd = true,
      view = {
        side = 'right',
        width = 70,
      },
      update_focused_file = {
        enable = true,
        update_root = {
          enable = false,
        },
      },
      git = {
        enable = true,
      },
      renderer = {
        root_folder_label = function(path)
          -- Get just the folder name without full path
          return vim.fn.fnamemodify(path, ':t')
        end,
        highlight_git = 'icon',
        highlight_opened_files = 'icon',
      },
    }
  end,
  keys = {
    { '<leader>e', '<cmd>NvimTreeFocus<cr>', desc = '[E]xplorer' },
    { '<leader>o', '<C-W><C-W>', desc = '[O]ther window' },
  },
}
