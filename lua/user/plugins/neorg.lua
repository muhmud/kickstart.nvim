return {
  'nvim-neorg/neorg',
  lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = '*', -- Pin Neorg to the latest stable release
  dependencies = {
    'nvim-neorg/lua-utils.nvim',
  },
  config = function()
    require('neorg').setup {
      load = {
        ['core.defaults'] = {},
        ['core.concealer'] = {
          config = {
            --icon_preset = 'varied',
          },
        },
        ['core.dirman'] = {
          config = {
            workspaces = {
              main = '~/notes', -- Format: <name_of_workspace> = <path_to_workspace_root>
            },
            default_workspace = 'main',
            index = 'index.norg', -- The name of the main (root) .norg file
          },
        },
      },
    }
  end,
}
