return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  build = ':Copilot auth',
  opts = {},
  config = function()
    require('copilot').setup {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = '<Tab>',
          accept_word = false,
          accept_line = false,
          next = '«', --Alt-Gr+z
          prev = '»', --Alt-Gr+x
          dismiss = 'æ', --Alt-Gr+a
        },
      },
      panel = { enabled = false },
    }
  end,
}
