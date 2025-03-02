return {
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

  -- Markdown Preview
  {
    'ellisonleao/glow.nvim',
    config = true,
    cmd = 'Glow',
  },

  -- Folding & Headlines for Better Markdown
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
  },
  {
    'lukas-reineke/headlines.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('headlines').setup {
        markdown = {
          headline_highlights = { 'Headline1', 'Headline2', 'Headline3' },
        },
      }
    end,
  },

  -- Note Linking / Wiki-Style Navigation
  {
    'renerocksai/telekasten.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },

  -- Vim Game for Improving Speed
  {
    'ThePrimeagen/vim-be-good',
    cmd = 'VimBeGood', -- Only load when the command is called
  },
  {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        log_level = 'error',
        auto_session_enabled = true,
        auto_session_root_dir = vim.fn.stdpath 'data' .. '/sessions/',
        auto_session_suppress_dirs = { '~', '~/Projects' },
      }
    end,
  },

  -- LaTeX Support
  {
    'lervag/vimtex',
    lazy = false, -- Don't lazy-load VimTeX
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
        dashboard.button('f', '  Find file', ':Telescope find_files<CR>'),
        dashboard.button('r', '  Recent files', ':Telescope oldfiles<CR>'),
        dashboard.button('q', '  Quit', ':qa<CR>'),
      }

      -- Change the footer
      dashboard.section.footer.val = 'Happy Coding!'

      -- Setup alpha with the modified dashboard
      alpha.setup(dashboard.opts)
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    event = 'BufReadPost',
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = false,
        keymap = {
          accept = '<C-l>',
          next = '<M-]>',
          prev = '<M-[>',
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
}
