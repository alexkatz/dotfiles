return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'hiphish/rainbow-delimiters.nvim',
    },
    opts = {
      auto_install = true,
      matchup = { enable = true },
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      playground = { enable = true },
      indent = { enable = true, disable = { 'python' } },
      incremental_selection = {
        keymaps = {
          init_selection = '<C-v>',
          node_incremental = '<C-v>',
          node_decremental = '<M-v>',
        },
      },
    },
    keys = {
      { '<C-v>', desc = 'Init selection' },
      { '<C-v>', desc = 'Increment selection', mode = 'x' },
      { '<M-v>', desc = 'Decrement selection', mode = 'x' },
    },
  },
}
