-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
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

  {
    'ellisonleao/glow.nvim',
    config = true,
    cmd = 'Glow',
  },

  {
    'ThePrimeagen/vim-be-good',
    cmd = 'VimBeGood', -- Only load when the command is called
  },
}
