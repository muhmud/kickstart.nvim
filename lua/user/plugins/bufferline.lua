return {
  'akinsho/bufferline.nvim',
  init = function()
    require('bufferline').setup {
      options = {
        separator_style = 'slant',
        indicator = {
          icon = ' ',
          style = 'icon',
        },
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'Explorer',
            highlight = 'PanelHeading',
            padding = 1,
          },
          {
            filetype = 'DiffviewFiles',
            text = 'Diff View',
            highlight = 'PanelHeading',
            padding = 1,
          },
          {
            filetype = 'lazy',
            text = 'Lazy',
            highlight = 'PanelHeading',
            padding = 1,
          },
        },
      },
    }
  end,
  dependencies = 'nvim-tree/nvim-web-devicons',
}
