return {
  'ggandor/lightspeed.nvim',
  lazy = false,
  config = function()
    require('lightspeed').setup {
      exit_after_idle_msecs = { labeled = 15000, unlabeled = 10000 },
      repeat_ft_with_target_char = true,
    }
  end,
  keys = {
    { 'S', '<Plug>Lightspeed_omni_s' },
  },
}
