return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  dependencies = {
    'nvim-treesitter',
  },
  config = function()
    require('nvim-treesitter.configs').setup {
      textobjects = {
        move = {
          enable = true,
          set_jumps = false,
          goto_next_start = {
            ['đ'] = '@function.outer', -- Alt-Gr+f
            ['þ'] = '@parameter.inner', -- Alt-Gr+p
            ['¢'] = '@conditional.outer', -- Alt-Gr+c
            ['ł'] = '@statement.outer', -- Alt-Gr+l
            ['“'] = '@block.outer', -- Alt-Gr+b
            ['ĸ'] = '@call.outer', -- Alt-Gr+k
          },
          goto_previous_start = {
            ['ª'] = '@function.outer', -- Alt-Gr+Shift-f
            ['Þ'] = '@parameter.inner', -- Alt-Gr+Shift+p
            ['©'] = '@conditional.outer', -- Alt-Gr+Shift+c
            ['Ł'] = '@statement.outer', -- Alt-Gr+Shift+l
            ['‘'] = '@block.outer', -- Alt-Gr+Shift+b
            ['&'] = '@call.outer', -- Alt-Gr+Shift+k
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<C-þ>'] = '@parameter.inner', -- C+Alt-Gr+p
          },
          swap_previous = {
            ['<C-Þ>'] = '@parameter.inner', -- C+Alt-Gr+Shift+p
          },
        },
      },
    }
  end,
}
