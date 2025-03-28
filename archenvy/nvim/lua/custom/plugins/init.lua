-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'kylechui/nvim-surround',
    version = '^3.0.0', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {}
    end,
  },
  -- Better Markdown Syntax Highlighting
  {
    'plasticboy/vim-markdown',
    ft = { 'markdown' },
    config = function()
      vim.g.vim_markdown_folding_disabled = 1 -- Disable folding
      vim.g.vim_markdown_conceal = 2 -- Conceal syntax
      vim.g.vim_markdown_conceal_code_blocks = 0
      vim.g.vim_markdown_math = 1 -- Enable math support
    end,
  },

  -- Table Formatting
  {
    'dhruvasagar/vim-table-mode',
    ft = { 'markdown' },
    config = function()
      vim.g.table_mode_corner = '|'
    end,
  },

  {
    'ellisonleao/glow.nvim',
    config = true,
    cmd = 'Glow',
  },

  {
    'ThePrimeagen/vim-be-good',
    cmd = 'VimBeGood', -- Only load when the command is called
  },

  {
    'lervag/vimtex',
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_compiler_method = 'latexmk'
      vim.g.vimtex_quickfix_ignore_filters = {
        'Underfull \\hbox',
        'Overfull \\hbox',
      }
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    event = 'BufReadPost',
    opts = {
      suggestion = {
        enabled = not vim.g.ai_cmp,
        auto_trigger = true,
        hide_during_completion = vim.g.ai_cmp,
        keymap = {
          accept = false, -- handled by nvim-cmp
          next = '<M-]>',
          prev = '<M-[>',
        },
      },
      panel = { enabled = false },
      filetypes = {
        ['*'] = true,
      },
    },
  },
  {
    'zbirenbaum/copilot-cmp',
    dependencies = { 'zbirenbaum/copilot.lua' },
    config = function()
      require('copilot_cmp').setup()
    end,
  },
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'

      dashboard.section.header.val = {
        '                                                                       ',
        '                                                                     ',
        '       ████ ██████           █████      ██                     ',
        '      ███████████             █████                             ',
        '      █████████ ███████████████████ ███   ███████████   ',
        '     █████████  ███    █████████████ █████ ██████████████   ',
        '    █████████ ██████████ █████████ █████ █████ ████ █████   ',
        '  ███████████ ███    ███ █████████ █████ █████ ████ █████  ',
        ' ██████  █████████████████████ ████ █████ █████ ████ ██████ ',
        '                                                                       ',
      }
      -- Customize the center buttons (commands)
      dashboard.section.buttons.val = {
        dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('f', '󰈞  Find file', ':Telescope find_files<CR>'),
        dashboard.button('r', '  Recent files', ':Telescope oldfiles<CR>'),
        dashboard.button('q', '󰈆  Quit', ':qa<CR>'),
      }

      -- Change the footer
      dashboard.section.footer.val = 'Happy Coding!'

      -- Setup alpha with the modified dashboard
      alpha.setup(dashboard.opts)
    end,
  },
}
