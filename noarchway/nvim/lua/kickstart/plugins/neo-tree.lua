-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    {
      '<leader>gp',
      function()
        -- Find the Git root directory
        local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
        if git_root and git_root ~= '' then
          -- Normalize the path and ensure it exists
          local stat = vim.loop.fs_stat(git_root)
          if stat then
            vim.cmd('Neotree focus dir=' .. git_root)
          else
            print 'Error: Git root directory not found'
          end
        else
          print 'Not in a Git repository'
        end
      end,
      desc = 'Open NeoTree at Git root',
      silent = true,
    },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
