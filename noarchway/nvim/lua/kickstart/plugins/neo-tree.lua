return {
  'nvim-neo-tree/neo-tree.nvim',
  -- no `cmd = "Neotree"`
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_hidden = false,
        },
        window = {
          mappings = {
            ['t'] = 'open_tabnew',
            ['s'] = 'open_split',
            ['v'] = 'open_vsplit',
          },
        },
      },
    }
  end,
  keys = {
    {
      '\\',
      function()
        require('neo-tree.command').execute { toggle = true, dir = vim.loop.cwd() }
      end,
      desc = 'Toggle Neo-tree',
    },
  },
}
