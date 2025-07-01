return {
  -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'olimorris/codecompanion.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!
    local builtin = require 'telescope.builtin'
    local ivyTheme = require('telescope.themes').get_ivy {
      previewer = false,
    }
    local ivyThemeWithPreview = require('telescope.themes').get_ivy {
      previewer = true,
    }

    -- Trouble
    local open_with_trouble = require('trouble.sources.telescope').open

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      -- defaults = {
      --   mappings = {
      --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
      --   },
      -- },
      -- defaults = {
      --   layout_config = {
      --     width = 120,
      --   },
      -- },
      pickers = {
        find_files = ivyThemeWithPreview,
        oldfiles = ivyThemeWithPreview,
        live_grep = ivyTheme,
        git_files = ivyThemeWithPreview,
        help_tags = ivyTheme,
        keymaps = ivyTheme,
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        fzf = {},
      },
      defaults = {
        mappings = {
          i = { ['<C-q>'] = open_with_trouble },
          n = { ['<C-q>'] = open_with_trouble },
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', 'ħ', builtin.help_tags, { desc = 'Search Help' }) -- Alt-Gr+h
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sb', function()
      builtin.find_files {
        cwd = vim.env.HOME,
      }
    end, { desc = '[S]earch Home Files' })
    -- Alt-Gr+s
    vim.keymap.set('n', 'ß', function()
      builtin.git_files {
        cwd = Get_git_root(),
      }
    end, { desc = 'Search Files' })
    -- Alt-Gr+g
    vim.keymap.set('n', 'ŋ', function()
      builtin.live_grep {
        cwd = Get_git_root(),
      }
    end, { desc = 'Search by Grep' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch Current [W]ord' })
    vim.keymap.set('n', 'ſ', builtin.grep_string, { desc = 'Search Current Word (<AltGr-w>)' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>s.', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>sr', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    -- Alt-Gr+r
    vim.keymap.set('n', '¶', function()
      builtin.oldfiles {
        prompt_title = 'Recent Files',
      }
    end, { desc = 'Search Recent Files' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily Search Current Buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep Open Files',
      }
    end, { desc = '[S]earch [/] Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sc', function()
      builtin.find_files {
        cwd = vim.fn.stdpath 'config',
        prompt_title = 'Neovim Config',
      }
    end, { desc = '[S]earch Neovim [C]onfig Files' })

    -- Search notes
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files {
        cwd = tostring(require('neorg').modules.get_module('core.dirman').get_current_workspace()[2]),
        prompt_title = 'Neorg Notes',
      }
    end)

    vim.keymap.set('n', '<leader>cg', function()
      vim.cmd [[ Telescope codecompanion theme=ivy ]]
    end)
  end,
  keys = {
    { '<leader>sh', '<cmd>lua require("telescope.builtin").help_tags()<cr>', desc = '[S]earch [H]elp' },
  },
}
