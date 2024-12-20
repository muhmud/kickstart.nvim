-- GUI-specific options and settings
if vim.env.NEOVIDE == '1' then
  vim.keymap.set('i', '<M-j>', '<cmd>:BufferLineCyclePrev<cr>')
  vim.keymap.set('i', '<M-k>', '<cmd>:BufferLineCycleNext<cr>')
  vim.keymap.set('n', '<M-j>', '<cmd>:BufferLineCyclePrev<cr>')
  vim.keymap.set('n', '<M-k>', '<cmd>:BufferLineCycleNext<cr>')

  vim.keymap.set('n', '<C-Tab>', '<C-W><C-W>')
  vim.keymap.set('i', '<C-Tab>', '<C-W><C-W>')
  vim.keymap.set('i', '<C-BS>', '<C-w>')
else
  vim.keymap.set('i', '<M-BS>', '<C-w>')
end

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<Esc><Esc>', '<cmd>NvimTreeClose<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', 'gy', "<cmd>:redir! @+ | echon join([expand('%'),  line('.')], ':') | redir END<CR>", { desc = 'Yank File/Line' })

vim.keymap.set('i', '<S-Insert>', '<C-R>+', { desc = 'Paste' })
vim.keymap.set('c', '<S-Insert>', '<C-R>+', { desc = 'Paste' })

vim.keymap.set('n', '0', '<cmd>:call SmartHome()<cr>')

vim.keymap.set('n', 'q', '<cmd>q<cr>')
vim.keymap.set('n', ',', '@@')
vim.keymap.set('n', 'Y', 'y$')

vim.keymap.set('n', '<leader>bs', '<cmd>:StripWhitespace<cr>', { desc = '[S]trip Whitespace' })
vim.keymap.set('n', '<leader>bw', '<cmd>call ToggleWrap()<cr>', { desc = 'Toggle [W]rap' })
vim.keymap.set('n', '<leader>bY', "<cmd>:echo expand('%:p') | let @+ = expand('%:p')<cr>", { desc = '[Y]ank Absolute Path' })
vim.keymap.set(
  'n',
  '<leader>by',
  "<cmd>:echo join([expand('%'), line('.')], ':') | let @+ = join([expand('%'), line('.')], ':')<cr>",
  { desc = '[Y]ank Relative Path/Line' }
)
vim.keymap.set('n', '<leader>bx', '<cmd>:BufferLineCloseLeft<CR>:BufferLineCloseRight<cr>', { desc = 'Close All E[X]cept Current' })
vim.keymap.set('n', '<leader>bl', '<cmd>Telescope buffers<cr>', { desc = 'Buffer [L]ist' })
vim.keymap.set('n', '<leader>c', '<cmd>:bdelete!<cr>', { desc = '[C]lose Buffer' })
vim.keymap.set('n', '<leader>bn', '<cmd>enew<cr>', { desc = '[N]ew Buffer' })
vim.keymap.set('n', '<leader>bp', '<cmd>:BufferLinePick<cr>', { desc = '[P]ick Buffer' })
vim.keymap.set('n', '<leader>j', '<cmd>:BufferLineCycleNext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<leader>k', '<cmd>:BufferLineCyclePrev<cr>', { desc = 'Previous Buffer' })

vim.keymap.set('n', '<leader>C', '<cmd>:e ~/.config/nvim/init.lua<cr>', { desc = 'Edit [C]onfig' })

vim.keymap.set('n', '<leader>lR', '<cmd>Trouble lsp_references<cr>', { desc = 'Show [R]eferences' })
vim.keymap.set('n', '<leader>lD', '<cmd>Trouble lsp_type_definitions<cr>', { desc = 'Type [D]efinition' })
vim.keymap.set('n', '<leader>ls', '<cmd>Trouble lsp_document_symbols<cr>', { desc = 'Document [S]ymbols' })
vim.keymap.set('n', '<leader>lS', "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>", { desc = 'Workspace [S]ymbols' })
vim.keymap.set('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = '[R]ename' })
vim.keymap.set('n', '<leader>ll', '<cmd>lua vim.lsp.codelens.run()<cr>', { desc = 'Code [L]ens Action' })
vim.keymap.set('n', '<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<cr>', { desc = '[Q]uickfix' })
vim.keymap.set('n', '<leader>lj', '<cmd>lua vim.diagnostic.goto_next()<cr>', { desc = 'Next Diagnostic' })
vim.keymap.set('n', '<leader>lk', '<cmd>lua vim.diagnostic.goto_prev()<cr>', { desc = 'Previous Diagnostic' })
vim.keymap.set('n', '<leader>lm', '<cmd>Mason<cr>', { desc = 'Mason' })

vim.keymap.set('v', 'n', ":'<,'>MoveBlock(1)<cr>", { desc = 'Move [N]ext' })
vim.keymap.set('v', 'p', ":'<,'>MoveBlock(-1)<cr>", { desc = 'Move [P]revious' })

vim.keymap.set('n', '<leader>q', '<cmd>qa<cr>', { desc = '[Q]uit' })

vim.keymap.set('n', 'ß', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', { desc = 'Workspace Symbols' })

vim.cmd [[
  nmap <silent> w <Plug>CamelCaseMotion_w
  nmap <silent> b <Plug>CamelCaseMotion_b
  nmap <silent> e <Plug>CamelCaseMotion_e
  nmap <silent> ge <Plug>CamelCaseMotion_ge

  omap <silent> iw <Plug>CamelCaseMotion_iw
  xmap <silent> iw <Plug>CamelCaseMotion_iw
  omap <silent> ib <Plug>CamelCaseMotion_ib
  xmap <silent> ib <Plug>CamelCaseMotion_ib
  omap <silent> ie <Plug>CamelCaseMotion_ie
  xmap <silent> ie <Plug>CamelCaseMotion_ie

  let g:surround_no_mappings = 1
  nmap ds       <Plug>Dsurround
  nmap cs       <Plug>Csurround
  nmap cS       <Plug>CSurround
  nmap ys       <Plug>Ysurround
  nmap yS       <Plug>YSurround
  nmap yss      <Plug>Yssurround
  nmap ySs      <Plug>YSsurround
  nmap ySS      <Plug>YSsurround
  xmap gs       <Plug>VSurround
  xmap gS       <Plug>VgSurround
]]
