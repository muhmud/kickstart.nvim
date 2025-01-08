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

-- Autocd
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    local filename = vim.fn.expand '%:t'
    if not filename:match '^NvimTree' then
      -- Only change directory if the buffer is a normal file/directory
      if vim.fn.expand('%:p'):match '^%w+://' == nil then
        vim.cmd.lcd(vim.fn.expand '%:p:h')
      end
    end
  end,
})
