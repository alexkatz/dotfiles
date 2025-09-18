return {
  'folke/flash.nvim',
  opts = {
    modes = {
      treesitter = {
        search = { incremental = true },
        label = { after = false, before = false },
      },
      treesitter_search = {
        jump = { pos = 'range' },
        search = { multi_window = true, wrap = true, incremental = false },
        remote_op = { restore = true },
        label = { before = true, after = true, style = 'inline' },
      },
    },
  },

  keys = {
    {
      '<CR>',
      function()
        require('flash').treesitter({
          actions = {
            ['<CR>'] = 'next',
            ['<BS>'] = 'prev',
          },
        })
      end,
      { desc = 'Treesitter incremental selection' },
    },

    {
      'S',
      function()
        require('flash').treesitter_search()
      end,
      { desc = 'Treesitter search' },
    },
  },
}
