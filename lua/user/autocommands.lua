-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Function to find git root directory or fallback to file's directory
function Get_git_root()
  -- Get the directory of the current buffer
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir = vim.fn.fnamemodify(current_file, ':p:h')

  -- Try to find git root
  local git_root = vim.fn.systemlist({ 'env', 'TERM=dumb', 'git', '-C', vim.fn.escape(current_dir, ' '), 'rev-parse', '--show-toplevel' })[1]

  if vim.v.shell_error == 0 and git_root ~= nil then
    return git_root
  else
    return current_dir
  end
end

-- Function to update nvim-tree root and reveal current file
function Update_tree_root()
  local nvim_tree = require 'nvim-tree'
  local api = require 'nvim-tree.api'
  local new_root = Get_git_root()
  local current_file = vim.api.nvim_buf_get_name(0)

  -- Only update if nvim-tree is visible
  local view = require 'nvim-tree.view'
  if view.is_visible() then
    -- Store the current window
    local current_win = vim.api.nvim_get_current_win()

    pcall(function()
      nvim_tree.change_dir(new_root)
    end)
    api.tree.find_file(current_file)

    -- Ensure focus stays on the current window
    vim.api.nvim_set_current_win(current_win)
  end
end

function Tree_focus()
  local current_file = vim.api.nvim_buf_get_name(0)
  vim.cmd 'NvimTreeFocus'
  vim.defer_fn(function()
    Update_tree_root()
    local api = require 'nvim-tree.api'
    api.tree.find_file(current_file)
  end, 10)
end

-- Autocd
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    local filename = vim.fn.expand '%:t'
    if not filename:match '^NvimTree' then
      -- Only change directory if the buffer is a normal file/directory
      if vim.fn.expand('%:p'):match '^%w+://' == nil then
        vim.cmd.lcd(vim.fn.expand '%:p:h')
        vim.defer_fn(function()
          Update_tree_root()
        end, 10)
      end
    end
  end,
})
