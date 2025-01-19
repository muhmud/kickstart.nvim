return {
  -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    vim.api.nvim_set_hl(0, 'MiniStatuslineFilename', { fg = '#abb2bf', bg = '#2f2d3d' })

    local function create_style(name, hl_name)
      local hl = vim.api.nvim_get_hl(0, { name = hl_name, link = false })
      local val = ''
      if hl ~= nil then
        if hl.reverse then
          val = string.format('%s=#%06x', name, hl.fg)
        elseif hl.bg ~= nil then
          val = string.format('%s=#%06x', name, hl.bg)
        else
          val = string.format('%s=#%06x', name, vim.api.nvim_get_hl(0, { name = 'Normal', link = false }).bg)
        end
      end
      return val
    end

    local function create_separator_style(before_hl, after_hl)
      local hl_name = string.format('Statusline%s%s', before_hl, after_hl)
      local before_val = create_style('guifg', before_hl)
      local after_val = create_style('guibg', after_hl)
      vim.cmd(string.format([[ hi! %s %s %s ]], hl_name, before_val, after_val))
    end

    local function create_statusline_separator(before_hl, after_hl, char)
      local hl_name = string.format('Statusline%s%s', before_hl, after_hl)
      return '%#' .. hl_name .. '#' .. char
    end

    local function create_statusline_style(before_hl, after_hl, fg, bg)
      local hl_name = string.format('Statusline%s%s', before_hl, after_hl)
      vim.api.nvim_set_hl(0, hl_name, { fg = fg, bg = bg })
    end

    -- set use_icons to true if you have a Nerd Font
    statusline.setup {
      use_icons = vim.g.have_nerd_font,
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
          local git = MiniStatusline.section_git { trunc_width = 40 }
          local diff = MiniStatusline.section_diff {
            trunc_width = 75,
            icon = '',
          }
          local diagnostics = MiniStatusline.section_diagnostics {
            trunc_width = 75,
            signs = {
              ERROR = '%#DiagnosticError#󰅚 ',
              WARN = '%#DiagnosticWarn#⚠️ ',
              INFO = '%#DiagnosticInfo#ℹ️ ',
              HINT = '%#DiagnosticHint#󰌵 ',
            },
            icon = '',
          }
          local lsp = MiniStatusline.section_lsp { trunc_width = 75 }
          local filename = MiniStatusline.section_filename { trunc_width = 140 }
          local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
          local location = MiniStatusline.section_location { trunc_width = 75 }
          local search = MiniStatusline.section_searchcount { trunc_width = 75 }

          return MiniStatusline.combine_groups {
            { hl = mode_hl, strings = { mode } },
            create_statusline_separator(mode_hl, 'MiniStatuslineDevinfo', ''),
            { hl = 'MiniStatuslineDevinfo', strings = { git, diff } },
            -- create_statusline_separator('MiniStatuslineDevinfo', 'DiagnosticHint', ''),
            { hl = 'DiagnosticHint', strings = { lsp } },
            { hl = 'DiagnosticHint', strings = { diagnostics } },
            --create_statusline_separator('DiagnosticHint', 'MiniStatuslineFilename', ''),
            '%<', -- Mark general truncate point
            { hl = 'MiniStatuslineFilename', strings = { filename } },
            '%=', -- End left alignment
            --create_statusline_separator('MiniStatuslineFilename', 'MiniStatuslineFileinfo', ''),
            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
            create_statusline_separator(mode_hl, 'MiniStatuslineFileinfo', ''),
            { hl = mode_hl, strings = { search, location } },
          }
        end,
      },
    }

    create_separator_style('MiniStatuslineModeNormal', 'MiniStatuslineDevinfo')
    create_separator_style('MiniStatuslineModeVisual', 'MiniStatuslineDevinfo')
    create_separator_style('MiniStatuslineModeInsert', 'MiniStatuslineDevinfo')
    create_separator_style('MiniStatuslineModeReplace', 'MiniStatuslineDevinfo')
    create_separator_style('MiniStatuslineModeCommand', 'MiniStatuslineDevinfo')
    create_separator_style('MiniStatuslineModeNormal', 'MiniStatuslineFileinfo')
    create_separator_style('MiniStatuslineModeVisual', 'MiniStatuslineFileinfo')
    create_separator_style('MiniStatuslineModeInsert', 'MiniStatuslineFileinfo')
    create_separator_style('MiniStatuslineModeReplace', 'MiniStatuslineFileinfo')
    create_separator_style('MiniStatuslineModeCommand', 'MiniStatuslineFileinfo')
    create_separator_style('MiniStatuslineDevinfo', 'DiagnosticHint')
    create_separator_style('DiagnosticHint', 'MiniStatuslineFilename')
    create_separator_style('MiniStatuslineFilename', 'MiniStatuslineFileinfo')

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      -- Calculate file progress percentage
      local current_line = vim.fn.line '.'
      local total_lines = vim.fn.line '$'
      local percentage = math.floor(current_line / total_lines * 100)
      local progress = string.format('%d%%', percentage)
      return '%2l:%-2v' .. ' ' .. progress .. '%'
    end

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
