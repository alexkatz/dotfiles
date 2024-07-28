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
  keys = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id

        vim.keymap.set('n', '<esc>', function()
          require('mini.files').close()
        end, { buffer = buf_id, desc = 'Close Mini Files' })
      end,
    })

    return {
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
    }
  end,
}
