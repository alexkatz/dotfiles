return {
  'echasnovski/mini.files',

  opts = function(_, opts)
    opts.options = {
      use_as_default_explorer = true,
    }

    opts.windows = {
      preview = true,
      width_nofocus = 40,
      width_focus = 40,
      width_preview = 100,
    }
  end,
  keys = {
    {
      '<leader>e',
      function()
        require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = 'Open mini.files ',
    },
    {
      '<esc>',
      function()
        require('mini.files').close()
      end,
      desc = 'Close mini.files',
    },
  },
}
