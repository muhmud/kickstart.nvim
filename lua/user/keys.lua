local newBufferCommand = ''
local closeBufferCommand = ''

-- GUI-specific options and settings
if vim.env.NEOVIDE == '1' then
  vim.keymap.set('i', '<M-j>', '<cmd>:BufferLineCyclePrev<cr>')
  vim.keymap.set('i', '<M-k>', '<cmd>:BufferLineCycleNext<cr>')
  vim.keymap.set('n', '<M-j>', '<cmd>:BufferLineCyclePrev<cr>')
  vim.keymap.set('n', '<M-k>', '<cmd>:BufferLineCycleNext<cr>')

  vim.keymap.set('n', '<C-Tab>', '<C-W><C-W>')
  vim.keymap.set('i', '<C-Tab>', '<C-W><C-W>')
  vim.keymap.set('i', '<C-BS>', '<C-w>')

  newBufferCommand = '<cmd>:call SwitchNew()<cr>'
  closeBufferCommand = '<cmd>:call SwitchClose()<cr>'
else
  vim.keymap.set('i', '<M-BS>', '<C-w>')

  newBufferCommand = '<cmd>enew<cr>'
  closeBufferCommand = '<cmd>q<cr>'
end

local keys = {
  keymaps = {
    { '<C-=>', '<cmd>:call ZoomIn()<CR>', description = 'Zoom In' },
    { '<C-->', '<cmd>:call ZoomOut()<CR>', description = 'Zoom Out' },
    { '<C-+>', '<cmd>:call ZoomReset()<CR>', description = 'Zoom Reset' },
    { '<leader>e', '<cmd>:NvimTreeFocus<CR>', description = '[E]xplorer' },
    { '<leader><leader>', '<cmd>:Legendary<CR>', description = 'Legend' },
    { '<Esc>', '<cmd>nohlsearch<CR>', description = 'Clear Search Highlights' },
    { '<Esc><Esc>', '<cmd>NvimTreeClose<CR>', description = 'Close Explorer' },
    { 'gy', "<cmd>:redir! @+ | echon join([expand('%'),  line('.')], ':') | redir END<CR>", description = 'Yank File/Line' },
    { 'gh', '<cmd>:BufferLinePick<cr>', description = 'Pick Buffer' },
    { '0', '<cmd>:call SmartHome()<cr>', description = 'Smart Home' },
    { ',', '@@', description = 'Repeat Last Macro' },
    { 'Y', 'y$', description = 'Yank to End of Line' },
    { '<leader>bs', '<cmd>:StripWhitespace<cr>', description = '[S]trip Whitespace' },
    { '<leader>bw', '<cmd>call ToggleWrap()<cr>', description = 'Toggle [W]rap' },
    { '<leader>bY', "<cmd>:echo expand('%:p') | let @+ = expand('%:p')<cr>", description = '[Y]ank Absolute Path' },
    {
      '<leader>by',
      "<cmd>:echo join([expand('%'), line('.')], ':') | let @+ = join([expand('%'), line('.')], ':')<cr>",
      description = '[Y]ank Relative Path/Line',
    },
    { '<leader>bx', '<cmd>:BufferLineCloseLeft<CR>:BufferLineCloseRight<cr>', description = 'Close All E[X]cept Current' },
    { '<leader>bl', '<cmd>Telescope buffers<cr>', description = 'Buffer [L]ist' },
    { '<leader>c', '<cmd>:bdelete<cr>', description = '[C]lose Buffer' },
    { '<leader>n', newBufferCommand, description = '[N]ew Buffer' },
    { '<leader>j', '<cmd>:BufferLineCycleNext<cr>', description = 'Next Buffer' },
    { '<leader>k', '<cmd>:BufferLineCyclePrev<cr>', description = 'Previous Buffer' },
    { '<leader>;', '<cmd>:Dashboard<cr>', description = 'Dashboard' },
    { '<leader>C', '<cmd>:e ~/.config/nvim/init.lua<cr>', description = 'Edit [C]onfig' },
    { '<leader>lR', '<cmd>Trouble lsp_references<cr>', description = 'Show [R]eferences' },
    { '<leader>lD', '<cmd>Trouble lsp_type_definitions<cr>', description = 'Type [D]efinition' },
    { '<leader>ls', '<cmd>Trouble lsp_document_symbols<cr>', description = 'Document [S]ymbols' },
    { '<leader>lS', "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>", description = 'Workspace [S]ymbols' },
    { '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', description = '[R]ename' },
    { '<leader>ll', '<cmd>lua vim.lsp.codelens.run()<cr>', description = 'Code [L]ens Action' },
    { '<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<cr>', description = '[Q]uickfix' },
    { '<leader>lj', '<cmd>lua vim.diagnostic.goto_next()<cr>', description = 'Next Diagnostic' },
    { '<leader>lk', '<cmd>lua vim.diagnostic.goto_prev()<cr>', description = 'Previous Diagnostic' },
    { '<leader>lm', '<cmd>Mason<cr>', description = '[M]ason' },
    { '<leader>q', '<cmd>qa<cr>', description = '[Q]uit' },
    { 'Q', closeBufferCommand, description = '[Q]uit Buffer' },
    { '<M-x>z', '<cmd>:MaximizerToggle<cr>', description = '[Z]oom Window' },
    { '<M-w>', '<cmd>:MoveWord(1)<cr>', description = 'Move [W]ord' },
    { '<M-b>', '<cmd>:MoveWord(-1)<cr>', description = 'Move Word [B]ack' },
    { '<M-n>', '<cmd>:MoveLine(1)<cr>', description = 'Move Line [N]ext' },
    { '<M-p>', '<cmd>:MoveLine(-1)<cr>', description = 'Move Line [P]revious' },
    { '“', '<cmd>Telescope buffers<cr>', description = 'List Buffers' }, -- AltGr+B
    { 'ß', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', description = 'List Workspace Symbols' }, -- AltGr+S
  },
  extensions = {
    which_key = {
      auto_register = true,
    },
    lazy_nvim = true,
  },
}

if vim.env.NEOVIDE == '1' then
  table.insert(keys.keymaps, { '<C-\\>', '<cmd>:split<cr>', description = 'Horizontal Split' })
  table.insert(keys.keymaps, { '<C-|>', '<cmd>:vsplit<cr>', description = 'Vertical Split' })
  table.insert(keys.keymaps, { '<C-h>', '<cmd>:wincmd h<cr>', description = 'Move focus to the left window' })
  table.insert(keys.keymaps, { '<C-S-h>', '<cmd>:wincmd H<cr>', description = 'Shift left window' })
  table.insert(keys.keymaps, { '<C-j>', '<cmd>:wincmd h<cr>', description = 'Move focus to the lower window' })
  table.insert(keys.keymaps, { '<C-S-j>', '<cmd>:wincmd H<cr>', description = 'Shift lower window' })
  table.insert(keys.keymaps, { '<C-k>', '<cmd>:wincmd h<cr>', description = 'Move focus to the upper window' })
  table.insert(keys.keymaps, { '<C-S-k>', '<cmd>:wincmd H<cr>', description = 'Shift upper window' })
  table.insert(keys.keymaps, { '<C-l>', '<cmd>:wincmd h<cr>', description = 'Move focus to the right window' })
  table.insert(keys.keymaps, { '<C-S-l>', '<cmd>:wincmd H<cr>', description = 'Shift right window' })
end

require('legendary').setup(keys)

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`

vim.keymap.set('i', '<C-=>', '<cmd>:call ZoomIn()<CR>', { desc = 'Zoom In' })
vim.keymap.set('i', '<C-->', '<cmd>:call ZoomOut()<CR>', { desc = 'Zoom Out' })
vim.keymap.set('i', '<C-+>', '<cmd>:call ZoomReset()<CR>', { desc = 'Zoom Reset' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands

vim.keymap.set('i', '<S-Insert>', '<C-R>+', { desc = 'Paste' })
vim.keymap.set('c', '<S-Insert>', '<C-R>+', { desc = 'Paste' })

--vim.keymap.set('n', 'q', '<cmd>q<cr>')

vim.keymap.set('v', '0', '<cmd>:call SmartHome()<cr>', { desc = 'Smart Home' })
vim.keymap.set('v', 'y', 'ygv<esc>', { desc = 'Yank' })
vim.keymap.set('v', '=', '=gv', { desc = 'Indent' })
vim.keymap.set('v', 'n', ":'<,'>MoveBlock(1)<cr>", { desc = 'Move [N]ext' })
vim.keymap.set('v', 'p', ":'<,'>MoveBlock(-1)<cr>", { desc = 'Move [P]revious' })

vim.keymap.set('v', '<C-=>', '<cmd>:call ZoomIn()<CR>', { desc = 'Zoom In' })
vim.keymap.set('v', '<C-->', '<cmd>:call ZoomOut()<CR>', { desc = 'Zoom Out' })
vim.keymap.set('v', '<C-+>', '<cmd>:call ZoomReset()<CR>', { desc = 'Zoom Reset' })

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
