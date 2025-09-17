return {
  'nvim-mini/mini.files',
  opts = function(_, opts)
    opts.windows = {
      max_number = math.huge,
      preview = true,
      width_focus = 40,
      width_nofocus = 40,
      width_preview = 120,
    }

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(event)
        vim.keymap.set('n', '<esc>', function()
          require('mini.files').close()
        end, { buffer = event.data.buf_id, desc = 'Close Mini Files' })
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesActionMove',
      callback = function(event)
        Snacks.rename.on_rename_file(event.data.from, event.data.to)
      end,
    })
  end,

  keys = {
    {
      '<leader>e',
      function()
        local MiniFiles = require('mini.files')
        if not MiniFiles.close() then
          MiniFiles.open(vim.api.nvim_buf_get_name(0), true)
        end
      end,
      desc = 'Open mini.files ',
    },
  },
}
